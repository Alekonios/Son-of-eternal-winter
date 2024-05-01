class_name Player

extends CharacterBody3D

@export var speed: float = 1.0
@export var jump: float = 2.0

var HP = 100

var cam_down_limit = 50
var cam_up_limit = -50

@onready var AK_ARMS_CAM_POS = $ARMS_CAM_POS
@onready var AK_ARMS_CAM_POS_AIM = $ARMS_CAM_POS/ak_aim_pos
@onready var PISTOL_ARMS_CAM_POS = $ARMS_CAM_POS/pistol_cam_pos
@onready var PISTOL_CAM_POS_AIM = $ARMS_CAM_POS/pistol_cam_pos/pistol_aim_pos
@onready var SNIPER_ARMS_CAM_POS = $ARMS_CAM_POS/sniper_cam_pos
@onready var SNIPER_CAM_POS_AIM = $ARMS_CAM_POS/sniper_cam_pos/sniper_aim_position
@onready var GEYGER_CAM_POS = $ARMS_CAM_POS/geyger_cam_pos
@onready var ARMS = $ARMS_CAM_POS/ak_aim_pos/ARMS
@onready var GEYGER_ORIG_NODE = $ARMS_CAM_POS/geyger_cam_pos/geiger_arms
@onready var AK_ORIG_NODE = $"ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms"
@onready var PISTOL_ORIG_NODE = $ARMS_CAM_POS/pistol_cam_pos/pistol_aim_pos/pistol_arms
@onready var SNIPER_ORIG_NODE = $ARMS_CAM_POS/sniper_cam_pos/sniper_aim_position/sniper_samopal_arms
@onready var AK_74 = $"ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/AK-74"
@onready var camera = $camera_node/Camera3D
@onready var viewport_camera = $SubViewportContainer/SubViewport/ViewCamera
@onready var sniper_animator = $ARMS_CAM_POS/sniper_cam_pos/sniper_aim_position/sniper_samopal_arms/AnimationPlayer
@onready var animator = $AnimationPlayer
@onready var ak_animator = $"ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/AnimationPlayer"
@onready var pistol_animator = $ARMS_CAM_POS/pistol_cam_pos/pistol_aim_pos/pistol_arms/AnimationPlayer
@onready var geyger_animator = $ARMS_CAM_POS/geyger_cam_pos/geiger_arms/AnimationPlayer
@onready var collider = $camera_node/Camera3D/RayCast3D
@onready var AK_collider = $"ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/RayCast3D"
@onready var PISTOL_collider = $"ARMS_CAM_POS/pistol_cam_pos/pistol_aim_pos/pistol_arms/Sketchfab_model/3ab9f780f2294ec8ba398c31f25c6b54_fbx/Object_2/RootNode/Armature/Object_6/Skeleton3D/Object_91/RayCast3D"
@onready var SNIPER_collider = $camera_node/Camera3D/sniper_raycasy

@onready var fires_AK = [$"ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/fires/fire", $"ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/fires/fire2", $"ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/fires/fire3", $"ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/fires/fire4", $"ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/fires/fire5", $"ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/fires/fire6", $"ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/fires/fire7", $"ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/fires/fire8", $"ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/fires/fire9", $"ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/fires/fire10"]
@onready var fires_pistol = [$"ARMS_CAM_POS/pistol_cam_pos/pistol_aim_pos/pistol_arms/Sketchfab_model/3ab9f780f2294ec8ba398c31f25c6b54_fbx/Object_2/RootNode/Armature/Object_6/fires/fire", $"ARMS_CAM_POS/pistol_cam_pos/pistol_aim_pos/pistol_arms/Sketchfab_model/3ab9f780f2294ec8ba398c31f25c6b54_fbx/Object_2/RootNode/Armature/Object_6/fires/fire2", $"ARMS_CAM_POS/pistol_cam_pos/pistol_aim_pos/pistol_arms/Sketchfab_model/3ab9f780f2294ec8ba398c31f25c6b54_fbx/Object_2/RootNode/Armature/Object_6/fires/fire3", $"ARMS_CAM_POS/pistol_cam_pos/pistol_aim_pos/pistol_arms/Sketchfab_model/3ab9f780f2294ec8ba398c31f25c6b54_fbx/Object_2/RootNode/Armature/Object_6/fires/fire4", $"ARMS_CAM_POS/pistol_cam_pos/pistol_aim_pos/pistol_arms/Sketchfab_model/3ab9f780f2294ec8ba398c31f25c6b54_fbx/Object_2/RootNode/Armature/Object_6/fires/fire5", $"ARMS_CAM_POS/pistol_cam_pos/pistol_aim_pos/pistol_arms/Sketchfab_model/3ab9f780f2294ec8ba398c31f25c6b54_fbx/Object_2/RootNode/Armature/Object_6/fires/fire6", $"ARMS_CAM_POS/pistol_cam_pos/pistol_aim_pos/pistol_arms/Sketchfab_model/3ab9f780f2294ec8ba398c31f25c6b54_fbx/Object_2/RootNode/Armature/Object_6/fires/fire7", $"ARMS_CAM_POS/pistol_cam_pos/pistol_aim_pos/pistol_arms/Sketchfab_model/3ab9f780f2294ec8ba398c31f25c6b54_fbx/Object_2/RootNode/Armature/Object_6/fires/fire8", $"ARMS_CAM_POS/pistol_cam_pos/pistol_aim_pos/pistol_arms/Sketchfab_model/3ab9f780f2294ec8ba398c31f25c6b54_fbx/Object_2/RootNode/Armature/Object_6/fires/fire9", $"ARMS_CAM_POS/pistol_cam_pos/pistol_aim_pos/pistol_arms/Sketchfab_model/3ab9f780f2294ec8ba398c31f25c6b54_fbx/Object_2/RootNode/Armature/Object_6/fires/fire10"]
@onready var fires_sniper = [$"ARMS_CAM_POS/sniper_cam_pos/sniper_aim_position/sniper_samopal_arms/Sketchfab_model/60e5ab10f37245dcb4931676588d48d0_fbx/Object_2/RootNode/Rig/Object_6/Skeleton3D/fires/fire", $"ARMS_CAM_POS/sniper_cam_pos/sniper_aim_position/sniper_samopal_arms/Sketchfab_model/60e5ab10f37245dcb4931676588d48d0_fbx/Object_2/RootNode/Rig/Object_6/Skeleton3D/fires/fire2", $"ARMS_CAM_POS/sniper_cam_pos/sniper_aim_position/sniper_samopal_arms/Sketchfab_model/60e5ab10f37245dcb4931676588d48d0_fbx/Object_2/RootNode/Rig/Object_6/Skeleton3D/fires/fire3", $"ARMS_CAM_POS/sniper_cam_pos/sniper_aim_position/sniper_samopal_arms/Sketchfab_model/60e5ab10f37245dcb4931676588d48d0_fbx/Object_2/RootNode/Rig/Object_6/Skeleton3D/fires/fire4", $"ARMS_CAM_POS/sniper_cam_pos/sniper_aim_position/sniper_samopal_arms/Sketchfab_model/60e5ab10f37245dcb4931676588d48d0_fbx/Object_2/RootNode/Rig/Object_6/Skeleton3D/fires/fire5", $"ARMS_CAM_POS/sniper_cam_pos/sniper_aim_position/sniper_samopal_arms/Sketchfab_model/60e5ab10f37245dcb4931676588d48d0_fbx/Object_2/RootNode/Rig/Object_6/Skeleton3D/fires/fire6", $"ARMS_CAM_POS/sniper_cam_pos/sniper_aim_position/sniper_samopal_arms/Sketchfab_model/60e5ab10f37245dcb4931676588d48d0_fbx/Object_2/RootNode/Rig/Object_6/Skeleton3D/fires/fire7", $"ARMS_CAM_POS/sniper_cam_pos/sniper_aim_position/sniper_samopal_arms/Sketchfab_model/60e5ab10f37245dcb4931676588d48d0_fbx/Object_2/RootNode/Rig/Object_6/Skeleton3D/fires/fire8", $"ARMS_CAM_POS/sniper_cam_pos/sniper_aim_position/sniper_samopal_arms/Sketchfab_model/60e5ab10f37245dcb4931676588d48d0_fbx/Object_2/RootNode/Rig/Object_6/Skeleton3D/fires/fire9", $"ARMS_CAM_POS/sniper_cam_pos/sniper_aim_position/sniper_samopal_arms/Sketchfab_model/60e5ab10f37245dcb4931676588d48d0_fbx/Object_2/RootNode/Rig/Object_6/Skeleton3D/fires/fire10"]

@onready var cam_origin = [$cam_positions/AK_positions/ak_def_position, $cam_positions/AK_positions/ak_walk_position, $cam_positions/AK_positions/ak_run_position, $cam_positions/def_positions/def_position, $cam_positions/def_positions/walk_position, $cam_positions/def_positions/run_position, $cam_positions/AK_positions/ak_aim, $cam_positions/pistol_positions/pistol_def_position, $cam_positions/pistol_positions/pistol_walk, $cam_positions/pistol_positions/pistol_run, $cam_positions/pistol_positions/pistol_aim, $cam_positions/sniper_positions/sniper_def_position, $cam_positions/sniper_positions/sniper_walk_position, $cam_positions/sniper_positions/sniper_run_position, $cam_positions/sniper_positions/sniper_aim_position]
@onready var ak_sounds = [$"ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/sounds/shoot_sound"]

var cycle_aim_logic = 0
var cycle_aim_anim = false
var new_gun = null
var weapon_in_hand = false
var weapons = [""]
var items = []
var ammo5_45 = []
var ammo9_19 = []
var ammo7_62 = []
var can_run = true
var shaking = false
var deleting = false
var take_geyger_anim_cd = false
@onready var player_2d = $SubViewportContainer

var object = null

enum states {IDLE, WALK, RUN, AIM_A, IDLE_A, WALK_A, RUN_A, SHOOT_A, RELOADING_A, AIM_P, IDLE_P, WALK_P, RUN_P, SHOOT_P, RELOADING_P, IDLE_GE, WALK_GE, RUN_GE, IDLE_S, WALK_S, RUN_S, AIM_S, SHOOT_S, RELOADING_S}

@export var state : states = states.IDLE

var mouse_sens =  0.05

var shooting = false
var shoot_cd
var moving = false
var is_run = false
var is_aim = false
var can_skip_weapon = false
var current_weapon
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	SNIPER_collider.global_transform = camera.global_transform
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$SubViewportContainer/SubViewport.size = DisplayServer.window_get_size()
	current_weapon = ""

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
			skip_weapon_cd(1)
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
	elif state == states.AIM_P:
		camera.global_position= lerp(camera.global_position, cam_origin[10].global_position, 0.1)
		pistol_animator.play("Armature|FPS_Pistol_Idle")
	elif state == states.RELOADING_P:
		skip_weapon_cd(1)
		speed = 1.0
		pistol_animator.play("Armature|FPS_Pistol_Reload_full")
		camera.global_position= lerp(camera.global_position, cam_origin[0].global_position, 0.1)
	elif state == states.IDLE_GE:
		camera.global_position= lerp(camera.global_position, cam_origin[0].global_position, 0.1)
		geyger_animator.play("geiger_idle")
	elif state == states.WALK_GE:
		camera.global_position= lerp(camera.global_position, cam_origin[1].global_position, 0.1)
		geyger_animator.play("geyger_walk")
		speed = 1.0
	elif state == states.IDLE_S:
		camera.global_position= lerp(camera.global_position, cam_origin[11].global_position, 0.1)
		if !sniper_animator.current_animation == "Rig|SRifle_Shot_nosight":
			sniper_animator.play("Rig|SRifle_Idle")
	elif state == states.WALK_S:
		speed = 1.0
		if state != states.AIM_S:
			camera.global_position= lerp(camera.global_position, cam_origin[12].global_position, 0.1)
		else:
			camera.global_position= lerp(camera.global_position, cam_origin[14].global_position, 0.1)
		sniper_animator.play("Rig|SRifle_Walk")
	elif state == states.RUN_S:
		speed = 1.2
		camera.global_position= lerp(camera.global_position, cam_origin[13].global_position, 0.1)
		sniper_animator.play("Rig|SRifle_Walk")
	elif state == states.AIM_S:
		#if state != states.RELOADING_S and sniper_animator.current_animation != "Rig|SRifle_Shot_nosight":
		camera.global_position= lerp(camera.global_position, cam_origin[14].global_position, 0.1)
		#elif sniper_animator.current_animation == "Rig|SRifle_Shot_nosight":
			#camera.global_position= lerp(camera.global_position, cam_origin[11].global_position, 0.1)
	elif state == states.RELOADING_S:
		camera.global_position= lerp(camera.global_position, cam_origin[11].global_position, 0.1)
		sniper_animator.play("Rig|SRifle_Reload_Full")
		
		
func skip_weapon_cd(time : float):
	if !can_skip_weapon:
		can_skip_weapon = true
		await get_tree().create_timer(time, false).timeout
		can_skip_weapon = false
		
func can_run_func():
	if !shooting:
		await get_tree().create_timer(1, false).timeout
		if !shooting:
			can_run = true

func delate_ammo_5_45():
	if !deleting:
		ammo5_45.pop_back()
		deleting = true
func delate_ammo_9_19():
	if !deleting:
		ammo9_19.pop_back()
		deleting = true
func delate_ammo_7_62():
	if !deleting:
		ammo7_62.pop_back()
		deleting = true

func sniper_shoot_sound_func():
	$ARMS_CAM_POS/sniper_cam_pos/sniper_aim_position/sniper_samopal_arms/shoot_sound.play()
	await get_tree().create_timer(0.2, false).timeout
	$ARMS_CAM_POS/sniper_cam_pos/sniper_aim_position/sniper_samopal_arms/zatvor_sound.play()
	
func _process(delta):
	$fps.text = str(Engine.get_frames_per_second())
	can_run_func()
	state_change()
	
	if Input.is_action_pressed("lc"):
		if weapon_in_hand and !shooting:
			if current_weapon == "AK-74" and ammo5_45.size() > 0:
				if AK_ORIG_NODE.ammo > 0 and !AK_ORIG_NODE.reloadnig:
					deleting = false
					can_run = false
					shooting = true
					ak_sounds[0].play()
					AK_ORIG_NODE.ammo -= 1
					ak_animator.play("Rig|AK_Shot")
					ak_animator.play("gilza")
					shoot_cd = 0.1
					kickback()
					camera_shake_func(0.003)
					shoot_func("_body")
					for i in fires_AK:
						i.rotation.z = randi_range(1, 360)
						i.show()
					await get_tree().create_timer(shoot_cd, false).timeout
					for i in fires_AK:
						i.hide()
					shooting = false
				else:
					delate_ammo_5_45()
					if ammo5_45.size() > 0:
						state = states.RELOADING_A
						AK_ORIG_NODE.ammo_reload()
			elif current_weapon == "pistol" and ammo9_19.size() > 0:
				if PISTOL_ORIG_NODE.ammo > 0 and !PISTOL_ORIG_NODE.reloadnig:
					deleting = false
					can_run = false
					shooting = true
					$"ARMS_CAM_POS/pistol_cam_pos/pistol_aim_pos/pistol_arms/Sketchfab_model/3ab9f780f2294ec8ba398c31f25c6b54_fbx/Object_2/RootNode/Armature/sound/shoot".play()
					PISTOL_ORIG_NODE.ammo -= 1
					pistol_animator.play("Armature|FPS_Pistol_Fire")
					shoot_cd = 0.2
					kickback()
					camera_shake_func(0.0006)
					shoot_func("_body")
					for i in fires_pistol:
						i.rotation.z = randi_range(1, 360)
						i.show()
					await get_tree().create_timer(0.1, false).timeout
					for i in fires_pistol:
						i.hide()
					await get_tree().create_timer(shoot_cd, false).timeout
					shooting = false
				else:
					delate_ammo_9_19()
					if ammo9_19.size() > 0:
						state = states.RELOADING_P
						PISTOL_ORIG_NODE.ammo_reload()
			elif current_weapon == "sniper-samopal" and ammo7_62.size() > 0:
				if SNIPER_ORIG_NODE.ammo > 0 and !SNIPER_ORIG_NODE.reloadnig:
					deleting = false
					can_run = false
					shooting = true
					sniper_shoot_sound_func()
					SNIPER_ORIG_NODE.ammo -= 1
					sniper_animator.play("Rig|SRifle_Shot_nosight")
					shoot_cd = 1.8
					kickback()
					camera_shake_func(0.001)
					shoot_func("_body")
					for i in fires_sniper:
						i.rotation.z = randi_range(1, 360)
						i.show()
					await get_tree().create_timer(0.1, false).timeout
					for i in fires_sniper:
						i.hide()
					await get_tree().create_timer(shoot_cd, false).timeout
					shooting = false
				else:
					delate_ammo_7_62()
					if ammo7_62.size() > 0:
						state = states.RELOADING_S
						SNIPER_ORIG_NODE.ammo_reload()

	if Input.is_action_just_pressed("r"):
		if weapon_in_hand:
			if current_weapon == "AK-74" and !AK_ORIG_NODE.reloadnig and ammo5_45.size() > 1:
				delate_ammo_5_45()
				deleting = false
				state = states.RELOADING_A
				AK_ORIG_NODE.ammo_reload()
			elif current_weapon == "pistol" and !PISTOL_ORIG_NODE.reloadnig and ammo9_19.size() > 1:
				deleting = false
				delate_ammo_9_19()
				state = states.RELOADING_P
				PISTOL_ORIG_NODE.ammo_reload()
			elif current_weapon == "sniper-samopal" and !SNIPER_ORIG_NODE.reloadnig and ammo7_62.size() > 1:
				deleting = false
				delate_ammo_7_62()
				state = states.RELOADING_S
				SNIPER_ORIG_NODE.ammo_reload()
				
func _physics_process(delta):
	states_logics()
	if not is_on_floor():
		velocity.y -= gravity * delta
				
	if Input.is_action_pressed("rc") and !cycle_aim_anim and !current_weapon == "" and !AK_ORIG_NODE.reloadnig and !PISTOL_ORIG_NODE.reloadnig and !current_weapon == "geyger" and !SNIPER_ORIG_NODE.reloadnig and !moving:
		is_aim = true
		if current_weapon == "AK-74":
			state = states.AIM_A
		elif current_weapon == "pistol":
			state = states.AIM_P
		elif  current_weapon == "sniper-samopal":
			state = states.AIM_S
		mouse_sens = 0.02
		#if camera.fov == 60:
			#for i in range(15):
				#if is_aim:
					#await get_tree().create_timer(0.007, false).timeout
					#camera.fov -= 2
				#else:
					#break
			#camera.fov = 30
		await get_tree().create_timer(0.15, false).timeout
		
		cycle_aim_anim = true
			
	
	elif !Input.is_action_pressed("rc") and cycle_aim_anim:
		if is_aim:
			is_aim = false
			mouse_sens = 0.05
			#if camera.fov == 30:
				#for i in range(15):
					#if !is_aim:
						#await get_tree().create_timer(0.007, false).timeout
						#camera.fov += 2
					#else:
						#break
			await get_tree().create_timer(0.15, false).timeout
			cycle_aim_anim = false
	
	if Input.is_action_pressed("shift") and Input.is_action_pressed("w") and state != states.RELOADING_A and can_run and current_weapon != "geyger" and ! state == states.RELOADING_P and !state == states.RELOADING_S:
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
		elif current_weapon == "pistol" and !PISTOL_ORIG_NODE.reloadnig:
			state = states.WALK_P
		elif current_weapon == "geyger":
			state = states.WALK_GE
		elif current_weapon == "sniper-samopal" and !SNIPER_ORIG_NODE.reloadnig:
			state = states.WALK_S
		if is_run and !shooting:
			if !current_weapon:
				state = states.RUN
			elif current_weapon == "AK-74":
				if !AK_ORIG_NODE.reloadnig:
					state = states.RUN_A
			elif current_weapon == "pistol":
				if !PISTOL_ORIG_NODE.reloadnig:
					state = states.RUN_P
			elif current_weapon == "sniper-samopal":
				if !SNIPER_ORIG_NODE.reloadnig:
					state = states.RUN_S
			
				
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
			if !is_aim and !PISTOL_ORIG_NODE.reloadnig:
				state = states.IDLE_P
			else:
				if !PISTOL_ORIG_NODE.reloadnig:
					state = states.AIM_P
		elif current_weapon == "geyger":
			state = states.IDLE_GE
		elif current_weapon == "sniper-samopal":
			if !is_aim and sniper_animator.current_animation != "Rig|SRifle_Shot_nosight" and !SNIPER_ORIG_NODE.reloadnig:
				state = states.IDLE_S
			elif is_aim and !SNIPER_ORIG_NODE.reloadnig and sniper_animator.current_animation != "Rig|SRifle_Shot_nosight":
				state = states.AIM_S
				
		
		
	move_and_slide()
	
func take_it(_body):
	if collider.is_colliding():
		if collider.get_collider() is Hitbox:
			_body = collider.get_collider()
			object = _body.get_parent()
			$sounds/big_item_take.play()
			if object.is_in_group("weapon"):
				weapons.push_back(object.gun_name)
				_body.activation(false, 0)
				weapon_in_hand = true
				if object.gun_name == "AK-74":
					ammo5_45.push_back("ammo-5.45")
				elif object.gun_name == "pistol":
					ammo9_19.push_back("ammo-9.19")
				elif object.gun_name == "sniper-samopal":
					ammo7_62.push_back("ammo-7.62")
			elif object.is_in_group("item"):
				items.push_back(object.item_name)
				_body.activation(false, 0)
			elif object.is_in_group("ammo"):
				if object.gun_name == "ammo-5.45":
					if ammo5_45.size() < 5:
						ammo5_45.push_back(object.gun_name)
						_body.activation(false, 0)
				elif object.gun_name == "ammo-9.19":
					if ammo9_19.size() < 5:
						ammo9_19.push_back(object.gun_name)
						_body.activation(false, 0)
				elif object.gun_name == "ammo-7.62":
					if ammo7_62.size() < 5:
						ammo7_62.push_back(object.gun_name)
						_body.activation(false, 0)
						
				
				
func shoot_func(_body):
	if current_weapon == "AK-74":
		if AK_collider.is_colliding():
			if AK_collider.get_collider() is Hitbox:
				_body = AK_collider.get_collider()
				_body.activation(true, 5)
	elif current_weapon == "pistol":
		if PISTOL_collider.is_colliding():
			if PISTOL_collider.get_collider() is Hitbox:
				_body = PISTOL_collider.get_collider()
				_body.activation(true, 2)
	elif current_weapon == "sniper-samopal":
		if SNIPER_collider.is_colliding():
			if SNIPER_collider.get_collider() is Hitbox:
				_body = SNIPER_collider.get_collider()
				_body.activation(true, 50)
				
			
func states_logics():
	if weapon_in_hand and !is_aim and current_weapon == "AK-74":
		AK_ARMS_CAM_POS.rotation.x = camera.rotation.x
		AK_ARMS_CAM_POS_AIM.rotation.x = 0
		GEYGER_CAM_POS.rotation.x = 0
		SNIPER_ARMS_CAM_POS.rotation.x = 0
		SNIPER_CAM_POS_AIM.rotation.x = 0
	elif weapon_in_hand and is_aim and current_weapon == "AK-74":
		AK_ARMS_CAM_POS_AIM.rotation.x = camera.rotation.x
		AK_ARMS_CAM_POS.rotation.x = 0
		GEYGER_CAM_POS.rotation.x = 0
	elif weapon_in_hand and !is_aim and current_weapon == "pistol":
		SNIPER_CAM_POS_AIM.rotation.x = 0
		AK_ARMS_CAM_POS.rotation.x = 0
		PISTOL_CAM_POS_AIM.rotation.x = 0
		GEYGER_CAM_POS.rotation.x = 0
		SNIPER_ARMS_CAM_POS.rotation.x = 0
		PISTOL_ARMS_CAM_POS.rotation.x = camera.rotation.x
	elif weapon_in_hand and is_aim and current_weapon == "pistol":
		PISTOL_ARMS_CAM_POS.rotation.x = 0
		GEYGER_CAM_POS.rotation.x = 0
		PISTOL_CAM_POS_AIM.rotation.x = camera.rotation.x
	elif weapon_in_hand and !is_aim and current_weapon == "sniper-samopal":
		AK_ARMS_CAM_POS.rotation.x = 0
		PISTOL_CAM_POS_AIM.rotation.x = 0
		GEYGER_CAM_POS.rotation.x = 0
		PISTOL_ARMS_CAM_POS.rotation.x = 0
		SNIPER_CAM_POS_AIM.rotation.x = 0
		SNIPER_ARMS_CAM_POS.rotation.x = camera.rotation.x
	elif weapon_in_hand and is_aim and current_weapon == "sniper-samopal":
		SNIPER_ARMS_CAM_POS.rotation.x = 0
		SNIPER_CAM_POS_AIM.rotation.x = camera.rotation.x
	elif current_weapon == "geyger":
		SNIPER_ARMS_CAM_POS.rotation.x = 0
		AK_ARMS_CAM_POS.rotation.x = 0
		PISTOL_ARMS_CAM_POS.rotation.x = 0
		GEYGER_CAM_POS.rotation.x = camera.rotation.x
		
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
	if Input.is_action_just_pressed("c"):
		for i in items:
			if i == "geyger" and !current_weapon == "geyger":
				current_weapon = "geyger"
				geyger_animator.play("geiger draw")
				switch_item()
		
	if Input.is_action_just_pressed("1") and current_weapon != weapons[0] and !AK_ORIG_NODE.reloadnig and !PISTOL_ORIG_NODE.reloadnig and !can_skip_weapon:
		switch_weapon(0)
	elif Input.is_action_just_pressed("2") and weapons.size() > 1 and current_weapon != weapons[1] and !AK_ORIG_NODE.reloadnig and !PISTOL_ORIG_NODE.reloadnig and !can_skip_weapon:
		switch_weapon(1)
	elif Input.is_action_just_pressed("3") and weapons.size() > 2 and current_weapon != weapons[2] and !AK_ORIG_NODE.reloadnig and !PISTOL_ORIG_NODE.reloadnig and !can_skip_weapon:
		switch_weapon(2)
	elif Input.is_action_just_pressed("4") and weapons.size() > 3 and current_weapon != weapons[3] and !AK_ORIG_NODE.reloadnig and !PISTOL_ORIG_NODE.reloadnig and !can_skip_weapon:
		switch_weapon(3)
	
	
		
func kickback():
	var random_x = randfn(0.002, -0.004)
	var random_y = randfn(0.02, 0.001)
	camera.global_position.x += random_x
	camera.rotation.x += random_y
	
func switch_weapon(weapon_index):
	if weapon_index < 0 or weapon_index >= weapons.size():
		pass
	else:
		current_weapon = weapons[weapon_index]
		player_2d.control_vis()
		update_weapon_visuals()
func switch_item():
	update_weapon_visuals()
	
func update_weapon_visuals():
	if current_weapon == "AK-74":
		skip_weapon_cd(0.3)
		AK_ARMS_CAM_POS.show()
		AK_ORIG_NODE.show()
		PISTOL_ORIG_NODE.hide()
		GEYGER_ORIG_NODE.hide()
		SNIPER_ORIG_NODE.hide()
		ak_animator.play("Rig|AK_Draw")
	elif current_weapon == "pistol":
		skip_weapon_cd(0.2)
		AK_ARMS_CAM_POS.show()
		PISTOL_ORIG_NODE.show()
		AK_ORIG_NODE.hide()
		GEYGER_ORIG_NODE.hide()
		SNIPER_ORIG_NODE.hide()
		pistol_animator.play("Armature|FPS_Pistol_Reload_easy")
	elif current_weapon == "":
		skip_weapon_cd(0.1)
		AK_ORIG_NODE.hide()
		PISTOL_ORIG_NODE.hide()
		GEYGER_ORIG_NODE.hide()
		SNIPER_ORIG_NODE.hide()
	elif current_weapon == "geyger":
		AK_ORIG_NODE.hide()
		PISTOL_ORIG_NODE.hide()
		GEYGER_ORIG_NODE.show()
		SNIPER_ORIG_NODE.hide()
		skip_weapon_cd(0.2)
	elif current_weapon == "sniper-samopal":
		AK_ORIG_NODE.hide()
		PISTOL_ORIG_NODE.hide()
		GEYGER_ORIG_NODE.hide()
		SNIPER_ORIG_NODE.show()
		skip_weapon_cd(0.2)
		
		
		
func camera_shake_func(shake_value : int):
	for i in range(3):
		if !shaking:
			shaking = true
			var shake_offset = Vector3(
			randf_range(-shake_value, shake_value), # Случайное смещение вдоль оси X
			randf_range(-shake_value, shake_value), # Случайное смещение вдоль оси Y
			randf_range(-shake_value, shake_value) # Случайное смещение вдоль оси Z
			)
			await get_tree().create_timer(0.03, false).timeout
			camera.global_transform.origin += shake_offset
			shaking = false
	
	
	


