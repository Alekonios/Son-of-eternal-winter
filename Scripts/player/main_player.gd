class_name Player

extends CharacterBody3D

@export var speed: float = 1.0
@export var jump: float = 2.0

@export var _Weapon_Manager : Weapon_Manager
@export var _Inventory_Manager : Inventory_Manager
@export var _State_Machine_Component : State_Machine_Component
@export var _Sounds_Component : Sound_Component

var adddf 

var HP = 100

var cam_down_limit = 50
var cam_up_limit = -50

@onready var GEYGER_ORIG_NODE = $ARMS_CAM_POS/geyger_cam_pos/geiger_arms
@onready var AK_ORIG_NODE = $"ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms"
@onready var PISTOL_ORIG_NODE = $ARMS_CAM_POS/pistol_cam_pos/pistol_aim_pos/pistol_arms
@onready var SNIPER_ORIG_NODE = $ARMS_CAM_POS/sniper_cam_pos/sniper_aim_position/sniper_samopal_arms
@onready var SAIGA_ORIG_NODE = $ARMS_CAM_POS/saiga_cam_pos/saiga_aim_pos/saiga_arms

@onready var camera = $camera_node
@onready var camera_orig = $camera_node/Camera3D
@onready var viewport_camera = $SubViewportContainer/SubViewport/ViewCamera
@onready var sniper_animator = $ARMS_CAM_POS/sniper_cam_pos/sniper_aim_position/sniper_samopal_arms/AnimationPlayer

var can_run = true
var shaking = false

var mouse_sens =  0.05

var shooting = false
var moving = false
var is_run = false
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$SubViewportContainer/SubViewport.size = DisplayServer.window_get_size()
		
func can_run_func():
	if _Weapon_Manager.shooting == false:
		await get_tree().create_timer(1, false).timeout
		if _Weapon_Manager.shooting == false:
			can_run = true
	
func _process(delta):
	$fps.text = str(Engine.get_frames_per_second())
	can_run_func()
	$camera_node/Camera3D/sniper_raycasy.global_transform = $"ARMS_CAM_POS/sniper_cam_pos/sniper_aim_position/sniper_samopal_arms/Sketchfab_model/60e5ab10f37245dcb4931676588d48d0_fbx/Object_2/RootNode/Rig/Object_6/Skeleton3D/BoneAttachment3D/nice_scope/SubViewport/Camera3D".global_transform

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
				
	
	if Input.is_action_pressed("shift") and Input.is_action_pressed("w") and _State_Machine_Component.state != _State_Machine_Component.states.RELOADING_A and can_run and _Inventory_Manager.current_weapon != "geyger" and ! _State_Machine_Component.state == _State_Machine_Component.states.RELOADING_P and _State_Machine_Component.state != _State_Machine_Component.states.RELOADING_S:
		is_run = true
	else:
		is_run = false

	if Input.is_action_just_pressed("space") and is_on_floor():
		velocity.y = jump * delta * 50

	var input_direction = Input.get_vector("d", "a", "s", "w")
	var direction = (transform.basis * Vector3(input_direction.x, 0, input_direction.y)).normalized()

	if input_direction:
		snow_steps_logic()
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		moving = true
		if !is_run and _Inventory_Manager.current_weapon == "":
			_State_Machine_Component.state = _State_Machine_Component.states.WALK
		elif _Inventory_Manager.current_weapon == "AK-74" and !AK_ORIG_NODE.reloadnig:
			_State_Machine_Component.state = _State_Machine_Component.states.WALK_A
		elif _Inventory_Manager.current_weapon == "pistol" and !PISTOL_ORIG_NODE.reloadnig:
			_State_Machine_Component.state = _State_Machine_Component.states.WALK_P
		elif _Inventory_Manager.current_weapon == "geyger":
			_State_Machine_Component.state = _State_Machine_Component.states.WALK_GE
		elif _Inventory_Manager.current_weapon == "sniper-samopal" and !SNIPER_ORIG_NODE.reloadnig:
			_State_Machine_Component.state = _State_Machine_Component.states.WALK_S
		elif _Inventory_Manager.current_weapon == "saiga" and !SAIGA_ORIG_NODE.reloadnig:
			_State_Machine_Component.state = _State_Machine_Component.states.WALK_SAI
		if is_run and _Weapon_Manager.shooting == false:
			if _Inventory_Manager.current_weapon == "":
				_State_Machine_Component.state = _State_Machine_Component.states.RUN
			elif _Inventory_Manager.current_weapon == "AK-74":
				if !AK_ORIG_NODE.reloadnig:
					_State_Machine_Component.state = _State_Machine_Component.states.RUN_A
			elif _Inventory_Manager.current_weapon == "pistol":
				if !PISTOL_ORIG_NODE.reloadnig:
					_State_Machine_Component.state = _State_Machine_Component.states.RUN_P
			elif _Inventory_Manager.current_weapon == "sniper-samopal":
				if !SNIPER_ORIG_NODE.reloadnig:
					_State_Machine_Component.state = _State_Machine_Component.states.RUN_S
			elif _Inventory_Manager.current_weapon == "saiga":
				if !SAIGA_ORIG_NODE.reloadnig:
					_State_Machine_Component.state = _State_Machine_Component.states.RUN_SAI
			
				
	else:
		moving = false
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
		if _Inventory_Manager.current_weapon == "" and _Weapon_Manager.is_aim == false:
			_State_Machine_Component.state = _State_Machine_Component.states.IDLE
		elif _Inventory_Manager.current_weapon == "AK-74":
			if _Weapon_Manager.is_aim == false and !AK_ORIG_NODE.reloadnig:
				_State_Machine_Component.state = _State_Machine_Component.states.IDLE_A
			else:
				if !AK_ORIG_NODE.reloadnig:
					_State_Machine_Component.state = _State_Machine_Component.states.AIM_A
		elif _Inventory_Manager.current_weapon == "saiga":
			if _Weapon_Manager.is_aim == false and !SAIGA_ORIG_NODE.reloadnig:
				_State_Machine_Component.state = _State_Machine_Component.states.IDLE_SAI
			else:
				if !SAIGA_ORIG_NODE.reloadnig:
					_State_Machine_Component.state = _State_Machine_Component.states.AIM_SAI
		elif _Inventory_Manager.current_weapon == "pistol":
			if _Weapon_Manager.is_aim == false and !PISTOL_ORIG_NODE.reloadnig:
				_State_Machine_Component.state = _State_Machine_Component.states.IDLE_P
			else:
				if !PISTOL_ORIG_NODE.reloadnig:
					_State_Machine_Component.state = _State_Machine_Component.states.AIM_P
		elif _Inventory_Manager.current_weapon == "geyger":
			_State_Machine_Component.state = _State_Machine_Component.states.IDLE_GE
		elif _Inventory_Manager.current_weapon == "sniper-samopal":
			if _Weapon_Manager.is_aim == false and sniper_animator.current_animation != "Rig|SRifle_Shot_nosight" and !SNIPER_ORIG_NODE.reloadnig:
				_State_Machine_Component.state = _State_Machine_Component.states.IDLE_S
			elif _Weapon_Manager.is_aim == true and !SNIPER_ORIG_NODE.reloadnig and sniper_animator.current_animation != "Rig|SRifle_Shot_nosight":
				_State_Machine_Component.state = _State_Machine_Component.states.AIM_S

	move_and_slide()

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
		camera.rotate_x(deg_to_rad(event.relative.y * mouse_sens))
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(60))
		viewport_camera.sway(Vector2(-event.relative.x, -event.relative.y))
		
func kickback(max_amount_x : float, min_amount_x : float , max_amount_y : float, min_amount_y : float):
	var random_x = randfn(max_amount_x, min_amount_x)
	var random_y = randfn(max_amount_y, min_amount_y)
	camera.rotation.x -= random_y
		
func camera_shake_func(shake_value : float):
	for i in range(3):
		if !shaking:
			shaking = true
			var shake_offset = Vector3(
			randf_range(-shake_value, shake_value), # Случайное смещение вдоль оси X
			randf_range(-shake_value, shake_value), # Случайное смещение вдоль оси Y
			0
			)
			await get_tree().create_timer(0.03, false).timeout
			camera_orig.global_transform.origin -= shake_offset
			shaking = false

func snow_steps_logic():
	if !is_run:
		_Sounds_Component.step_snow_sounds_walk()
	else:
		_Sounds_Component.step_snow_sounds_run()

