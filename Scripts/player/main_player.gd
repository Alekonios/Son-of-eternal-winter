class_name Player

extends CharacterBody3D

@export var speed: float = 1.0
@export var jump: float = 2.0


var cam_down_limit = 50
var cam_up_limit = -50

@onready var AK_ARMS_CAM_POS = $ARMS_CAM_POS
@onready var AK_ARMS_CAM_POS_AIM = $ARMS_CAM_POS/ak_aim_pos
@onready var PISTOL_ARMS_CAM_POS = $ARMS_CAM_POS/pistol_cam_pos
@onready var PISTOL_CAM_POS_AIM = $ARMS_CAM_POS/pistol_cam_pos/pistol_aim_pos
@onready var ARMS = $ARMS_CAM_POS/ak_aim_pos/ARMS
@onready var AK_ORIG_NODE = $"ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms"
@onready var PISTOL_ORIG_NODE = $ARMS_CAM_POS/pistol_cam_pos/pistol_aim_pos/pistol_arms
@onready var AK_74 = $"ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/AK-74"
@onready var camera = $camera_node/Camera3D
@onready var animator = $AnimationPlayer
@onready var ak_animator = $"ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/AnimationPlayer"
@onready var pistol_animator = $ARMS_CAM_POS/pistol_cam_pos/pistol_aim_pos/pistol_arms/AnimationPlayer
@onready var collider = $camera_node/Camera3D/RayCast3D
@onready var AK_collider = $camera_node/Camera3D/AK_SHOOT_RAYCAST

@onready var fires_AK = [$"ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/fires/fire", $"ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/fires/fire2", $"ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/fires/fire3", $"ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/fires/fire4", $"ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/fires/fire5", $"ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/fires/fire6", $"ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/fires/fire7", $"ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/fires/fire8", $"ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/fires/fire9", $"ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/fires/fire10"]

@onready var cam_origin = [$cam_positions/AK_positions/ak_def_position, $cam_positions/AK_positions/ak_walk_position, $cam_positions/AK_positions/ak_run_position, $cam_positions/def_positions/def_position, $cam_positions/def_positions/walk_position, $cam_positions/def_positions/run_position, $cam_positions/AK_positions/ak_aim, $cam_positions/pistol_positions/pistol_def_position, $cam_positions/pistol_positions/pistol_walk, $cam_positions/pistol_positions/pistol_run, $cam_positions/pistol_positions/pistol_aim]
@onready var ak_sounds = [$"ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/sounds/shoot_sound"]

var cycle_aim_logic = 0
var cycle_aim_anim = false
var new_gun = null
var weapon_in_hand = false
var weapons = [""]

var object = null

enum states {IDLE, WALK, RUN, AIM_A, IDLE_A, WALK_A, RUN_A, SHOOT_A, RELOADING_A, AIM_P, IDLE_P, WALK_P, RUN_P, SHOOT_P, RELOADING_P}

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
	$SubViewportContainer/SubViewport.size = DisplayServer.window_get_size()

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
	elif state == states.RELOADING_A:
		if AK_ORIG_NODE.reloadnig:
			speed = 1.0
			ak_animator.play("Rig|AK_Reload_full")
			camera.global_position= lerp(camera.global_position, cam_origin[0].global_position, 0.1)
	elif state == states.WALK_P:
		camera.global_position= lerp(camera.global_position, cam_origin[0].global_position, 0.1)
		speed = 1.0
		pistol_animator.play("Armature|FPS_Pistol_Walk")
		camera.global_position= lerp(camera.global_position, cam_origin[8].global_position, 0.1)
	elif state == states.RUN_P:
		speed = 2.0
		camera.global_position= lerp(camera.global_position, cam_origin[9].global_position, 0.1)
		pistol_animator.play("Armature|FPS_Pistol_Walk")
	elif state == states.IDLE_P:
		camera.global_position= lerp(camera.global_position, cam_origin[7].global_position, 0.1)
		pistol_animator.play("Armature|FPS_Pistol_Idle")
	
			
		
		
func _process(delta):
	state_change()
	print(weapons)
	
	if Input.is_action_pressed("lc"):
		if weapon_in_hand and !shooting:
			if current_weapon == "AK-74":
				if AK_ORIG_NODE.ammo > 0:
					shooting = true
					ak_sounds[0].play()
					AK_ORIG_NODE.ammo -= 1
					print(AK_ORIG_NODE.ammo)
					shoot_cd = 0.1
					kickback()
					ak_animator.play("Rig|AK_Shot")
					ak_animator.play("gilza")
					shoot_func("_body")
					for i in fires_AK:
						i.rotation.z = randi_range(1, 360)
						i.show()
					await get_tree().create_timer(shoot_cd, false).timeout
					for i in fires_AK:
						i.hide()
					shooting = false
				else:
					state = states.RELOADING_A
					AK_ORIG_NODE.ammo_reload()
	if Input.is_action_just_pressed("r"):
		if weapon_in_hand:
			if current_weapon == "AK-74" and !AK_ORIG_NODE.reloadnig:
				state = states.RELOADING_A
				AK_ORIG_NODE.ammo_reload()
				
		

func _physics_process(delta):
	print(current_weapon)
	states_logics()
	if not is_on_floor():
		velocity.y -= gravity * delta
				
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
	
	if Input.is_action_pressed("shift") and Input.is_action_pressed("w") and state != states.RELOADING_A and state != states.SHOOT_A:
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
		elif current_weapon == "AK-74" and !AK_ORIG_NODE.reloadnig:
			state = states.WALK_A
		elif current_weapon == "pistol":
			state = states.WALK_P
		if is_run:
			if !current_weapon:
				state = states.RUN
			elif current_weapon == "AK-74":
				if !AK_ORIG_NODE.reloadnig:
					state = states.RUN_A
			elif current_weapon == "pistol":
				state = states.RUN_P
			
				
	else:
		moving = false
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
		if !current_weapon and !is_aim:
			state = states.IDLE
		elif current_weapon == "AK-74":
			if !is_aim and !AK_ORIG_NODE.reloadnig:
				state = states.IDLE_A
			else:
				if !AK_ORIG_NODE.reloadnig:
					state = states.AIM_A
		elif current_weapon == "pistol":
			state = states.IDLE_P
		
	move_and_slide()
	
func take_it(_body):
	if collider.is_colliding():
		if collider.get_collider() is Hitbox:
			_body = collider.get_collider()
			object = _body.get_parent()
			if object.is_in_group("weapon"):
				weapons.push_back(object.gun_name)
				_body.activation(false, 0)
				weapon_in_hand = true
				
func shoot_func(_body):
	if AK_collider.is_colliding():
		if AK_collider.get_collider() is Hitbox:
			_body = AK_collider.get_collider()
			_body.activation(true, 5)
			
func states_logics():
	if weapon_in_hand and !is_aim and current_weapon == "AK-74":
		AK_ARMS_CAM_POS.rotation.x = camera.rotation.x
		AK_ARMS_CAM_POS_AIM.rotation.x = 0
	elif weapon_in_hand and is_aim and current_weapon == "AK-74":
		AK_ARMS_CAM_POS_AIM.rotation.x = camera.rotation.x
		AK_ARMS_CAM_POS.rotation.x = 0
	elif weapon_in_hand and !is_aim and current_weapon == "pistol":
		AK_ARMS_CAM_POS.rotation.x = 0
		PISTOL_ARMS_CAM_POS.rotation.x = camera.rotation.x
		
	elif !is_aim and current_weapon != "AK-74":
		ARMS.rotation.x = 0
	elif !is_aim and current_weapon != "pistol":
		ARMS.rotation.x = 0
			

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
		camera.rotate_x(deg_to_rad(event.relative.y * -mouse_sens))
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-50), deg_to_rad(50))
	if Input.is_action_just_pressed("e"):
		take_it("_body")
		
	if Input.is_action_just_pressed("1") and current_weapon != weapons[0]:
		switch_weapon(0)
	elif Input.is_action_just_pressed("2") and current_weapon != weapons[1]:
		switch_weapon(1)
	elif Input.is_action_just_pressed("3") and current_weapon != weapons[2]:
		switch_weapon(2)
	
		
func kickback():
	var random_x = randfn(0.002, -0.004)
	var random_y = randfn(0.01, 0.001)
	camera.global_position.x += random_x
	camera.rotation.x += random_y
	
func switch_weapon(weapon_index):
	if weapon_index < 0 or weapon_index >= weapons.size():
		pass
	else:
		current_weapon = weapons[weapon_index]
		update_weapon_visuals()
	
func update_weapon_visuals():
	if current_weapon == "AK-74":
		AK_ARMS_CAM_POS.show()
		AK_ORIG_NODE.show()
		PISTOL_ORIG_NODE.hide()
		ak_animator.play("Rig|AK_Draw")
	elif current_weapon == "pistol":
		AK_ARMS_CAM_POS.show()
		PISTOL_ORIG_NODE.show()
		AK_ORIG_NODE.hide()
		pistol_animator.play("Armature|FPS_Pistol_Reload_easy")
	elif current_weapon == "":
		AK_ARMS_CAM_POS.hide()
	
	
	


