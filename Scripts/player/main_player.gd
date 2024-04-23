class_name Player

extends CharacterBody3D

@export var speed: float = 1.0
@export var jump: float = 2.0
@onready var fire = $"ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/MeshInstance3D"

var cam_down_limit = 50
var cam_up_limit = -50

@onready var AK_ARMS_CAM_POS = $ARMS_CAM_POS
@onready var AK_ARMS_CAM_POS_AIM = $ARMS_CAM_POS/ak_aim_pos
@onready var ARMS = $ARMS_CAM_POS/ak_aim_pos/ARMS
@onready var AK_ORIG_NODE = $"ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms"
@onready var AK_74 = $"ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/AK-74"
@onready var left_arm = $Armature/Skeleton3D/Left_full_arm
@onready var rigt_arm = $Armature/Skeleton3D/right_arm
@onready var camera = $camera_node/Camera3D
@onready var animator = $AnimationPlayer
@onready var ak_animator = $"ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/AnimationPlayer"
@onready var collider = $camera_node/Camera3D/RayCast3D

@onready var cam_origin = [$cam_positions/AK_positions/ak_def_position, $cam_positions/AK_positions/ak_walk_position, $cam_positions/AK_positions/ak_run_position, $cam_positions/def_positions/def_position, $cam_positions/def_positions/walk_position, $cam_positions/def_positions/run_position, $cam_positions/AK_positions/ak_aim]

var cycle_aim_logic = 0
var cycle_aim_anim = false
var new_gun = null
var weapon_in_hand = false
var weapons = []

var object = null

enum states {IDLE, WALK, RUN, AIM_A, IDLE_A, WALK_A, RUN_A, SHOOT_A}

@export var state : states = states.IDLE

var mouse_sens =  0.05

var shooting = false
var shoot_cd
var moving = false
var is_run = false
var is_aim = false
var current_weapon
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func state_change():
	if state == states.IDLE:
		animator.play("stat_idle")
		camera.global_position = lerp(camera.global_position, cam_origin[3].global_position, 0.1)
	elif state == states.WALK:
		animator.play("STAT-idle")
		speed = 1.0
		camera.global_position = lerp(camera.global_position, cam_origin[4].global_position, 0.1)
	elif state == states.RUN: 
		animator.play("run")
		speed = 2.0
		camera.global_position= lerp(camera.global_position, cam_origin[5].global_position, 0.1)
	elif state == states.IDLE_A:
		animator.play("idle with automat")
		ak_animator.play("Rig|AK_Idle")
		camera.global_position= lerp(camera.global_position, cam_origin[0].global_position, 0.1)
	elif state == states.WALK_A:
		animator.play("walk with automat")
		ak_animator.play("Rig|AK_Walk")
		camera.global_position= lerp(camera.global_position, cam_origin[1].global_position, 0.1)
		speed = 1.0
	elif state == states.RUN_A:
		speed = 2.0
		animator.play("run with automat 2")
		ak_animator.play("Rig|AK_Run")
		camera.global_position= lerp(camera.global_position, cam_origin[2].global_position, 0.1)
	elif state == states.AIM_A:
		animator.play("idle with automat")
		ak_animator.play("Rig|AK_Idle")
		camera.global_position= lerp(camera.global_position, cam_origin[6].global_position, 0.1)
		
		
		

func _physics_process(delta):
	states_logics()
	inventory_system()
	state_change()
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	if Input.is_action_pressed("lc") and !shooting:
		if weapon_in_hand:
			print(current_weapon)
			if current_weapon == "AK-74":
				shooting = true
				shoot_cd = 0.1
				print("FIRE")
				shoot_func("_body")
				fire.show()
				await get_tree().create_timer(shoot_cd, false).timeout
				fire.hide()
				shooting = false
			
	
	if Input.is_action_pressed("rc") and !cycle_aim_anim:
		is_aim = true
		state = states.AIM_A
		mouse_sens = 0.02
		if camera.fov == 60:
			for i in range(15):
				if is_aim:
					await get_tree().create_timer(0.007, false).timeout
					camera.fov -= 2
				else:
					break
			camera.fov = 30
			await get_tree().create_timer(0.5, false).timeout
			cycle_aim_anim = true
	
	elif !Input.is_action_pressed("rc") and cycle_aim_anim:
		if is_aim:
			is_aim = false
			mouse_sens = 0.05
			if camera.fov == 30:
				for i in range(15):
					if !is_aim:
						await get_tree().create_timer(0.007, false).timeout
						camera.fov += 2
					else:
						break
				camera.fov = 60
				await get_tree().create_timer(0.5, false).timeout
				cycle_aim_anim = false
	
	if Input.is_action_pressed("shift") and Input.is_action_pressed("w"):
		is_run = true
	else:
		is_run = false

	if Input.is_action_just_pressed("space") and is_on_floor():
		velocity.y = jump * delta * 50

	var input_direction = Input.get_vector("d", "a", "s", "w")
	var direction = (transform.basis * Vector3(input_direction.x, 0, input_direction.y)).normalized()

	if input_direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		moving = true
		if !is_run and !current_weapon:
			state = states.WALK
		elif current_weapon == "AK-74":
			state = states.WALK_A
		if is_run:
			if !current_weapon:
				state = states.RUN
			elif current_weapon == "AK-74":
				state = states.RUN_A
				
	else:
		moving = false
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
		if !current_weapon and !is_aim:
			state = states.IDLE
		elif current_weapon == "AK-74":
			if !is_aim:
				state = states.IDLE_A
			else:
				state = states.AIM_A
		
	move_and_slide()
	
func take_it(_body):
	if collider.is_colliding():
		if collider.get_collider() is Hitbox:
			_body = collider.get_collider()
			object = _body.get_parent()
			if object.is_in_group("weapon"):
				weapons.push_back(object.gun_name)
				_body.activation(false, 0)
				if object.gun_name == "AK-74":
					AK_74.show()
				weapon_in_hand = true
				
func shoot_func(_body):
	if collider.is_colliding():
		if collider.get_collider() is Hitbox:
			_body = collider.get_collider()
			_body.activation(true, 5)
			
	

func states_logics():
	if weapon_in_hand and !is_aim:
		AK_ARMS_CAM_POS.rotation.x = camera.rotation.x
		AK_ARMS_CAM_POS_AIM.rotation.x = 0
	elif weapon_in_hand and is_aim:
		AK_ARMS_CAM_POS_AIM.rotation.x = camera.rotation.x
		AK_ARMS_CAM_POS.rotation.x = 0
	elif !weapon_in_hand and !is_aim:
		ARMS.rotation.x = 0
	

func inventory_system():
	if weapons.size() >= 1:
		for i in weapons:
			if i == "AK-74" and !current_weapon:
				current_weapon = "AK-74"

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
		camera.rotate_x(deg_to_rad(event.relative.y * -mouse_sens))
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-50), deg_to_rad(50))
			
	if Input.is_action_just_pressed("e"):
		take_it("_body")


