class_name Weapon_Manager

extends Node3D

@export var smoke_part : GPUParticles3D
@export var _Sound_Component : Sound_Component
@export var _Inventory_Manager : Inventory_Manager
@export var _State_Machine_Component : State_Machine_Component
@onready var camera = $"../camera_node/Camera3D"

var can_skip_weapon = false
var shooting = false
var shoot_cd
var cycle_aim_anim = false
var is_aim = false

var bullet_hole = preload("res://Scenes/Other/buller_hole.tscn")
var traser = preload("res://Scenes/Other/traser.tscn")

@onready var AK_collider = $"../ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/BoneAttachment3D/RayCast3D"
@onready var saiga_collider = $"../ARMS_CAM_POS/saiga_cam_pos/saiga_aim_pos/saiga_arms/Sketchfab_model/95ac79517a844ea1b13875322aa37f27_fbx/Object_2/RootNode/Rig/Object_6/Skeleton3D/BoneAttachment3D/RayCast3D"
@onready var PISTOL_collider = $"../ARMS_CAM_POS/pistol_cam_pos/pistol_aim_pos/pistol_arms/Sketchfab_model/3ab9f780f2294ec8ba398c31f25c6b54_fbx/Object_2/RootNode/Armature/Object_6/Skeleton3D/Object_91/RayCast3D"
@onready var SNIPER_collider = $"../camera_node/Camera3D/sniper_raycasy"
@onready var SAIGA_collider = $"../ARMS_CAM_POS/saiga_cam_pos/saiga_aim_pos/saiga_arms/Sketchfab_model/95ac79517a844ea1b13875322aa37f27_fbx/Object_2/RootNode/Rig/Object_6/Skeleton3D/BoneAttachment3D/RayCast3D"
@onready var fires_sniper = [$"../ARMS_CAM_POS/sniper_cam_pos/sniper_aim_position/sniper_samopal_arms/Sketchfab_model/60e5ab10f37245dcb4931676588d48d0_fbx/Object_2/RootNode/Rig/Object_6/Skeleton3D/fires/fire", $"../ARMS_CAM_POS/sniper_cam_pos/sniper_aim_position/sniper_samopal_arms/Sketchfab_model/60e5ab10f37245dcb4931676588d48d0_fbx/Object_2/RootNode/Rig/Object_6/Skeleton3D/fires/fire2", $"../ARMS_CAM_POS/sniper_cam_pos/sniper_aim_position/sniper_samopal_arms/Sketchfab_model/60e5ab10f37245dcb4931676588d48d0_fbx/Object_2/RootNode/Rig/Object_6/Skeleton3D/fires/fire3", $"../ARMS_CAM_POS/sniper_cam_pos/sniper_aim_position/sniper_samopal_arms/Sketchfab_model/60e5ab10f37245dcb4931676588d48d0_fbx/Object_2/RootNode/Rig/Object_6/Skeleton3D/fires/fire4", $"../ARMS_CAM_POS/sniper_cam_pos/sniper_aim_position/sniper_samopal_arms/Sketchfab_model/60e5ab10f37245dcb4931676588d48d0_fbx/Object_2/RootNode/Rig/Object_6/Skeleton3D/fires/fire5", $"../ARMS_CAM_POS/sniper_cam_pos/sniper_aim_position/sniper_samopal_arms/Sketchfab_model/60e5ab10f37245dcb4931676588d48d0_fbx/Object_2/RootNode/Rig/Object_6/Skeleton3D/fires/fire6", $"../ARMS_CAM_POS/sniper_cam_pos/sniper_aim_position/sniper_samopal_arms/Sketchfab_model/60e5ab10f37245dcb4931676588d48d0_fbx/Object_2/RootNode/Rig/Object_6/Skeleton3D/fires/fire7", $"../ARMS_CAM_POS/sniper_cam_pos/sniper_aim_position/sniper_samopal_arms/Sketchfab_model/60e5ab10f37245dcb4931676588d48d0_fbx/Object_2/RootNode/Rig/Object_6/Skeleton3D/fires/fire8", $"../ARMS_CAM_POS/sniper_cam_pos/sniper_aim_position/sniper_samopal_arms/Sketchfab_model/60e5ab10f37245dcb4931676588d48d0_fbx/Object_2/RootNode/Rig/Object_6/Skeleton3D/fires/fire9", $"../ARMS_CAM_POS/sniper_cam_pos/sniper_aim_position/sniper_samopal_arms/Sketchfab_model/60e5ab10f37245dcb4931676588d48d0_fbx/Object_2/RootNode/Rig/Object_6/Skeleton3D/fires/fire10"]
@onready var fires_pistol = [$"../ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/fires/fire", $"../ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/fires/fire2", $"../ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/fires/fire3", $"../ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/fires/fire4", $"../ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/fires/fire5", $"../ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/fires/fire6", $"../ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/fires/fire7", $"../ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/fires/fire8", $"../ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/fires/fire9", $"../ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/fires/fire10"]
@onready var fires_AK = [$"../ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/fires/fire", $"../ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/fires/fire2", $"../ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/fires/fire3", $"../ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/fires/fire4", $"../ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/fires/fire5", $"../ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/fires/fire6", $"../ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/fires/fire7", $"../ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/fires/fire8", $"../ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/fires/fire9", $"../ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/fires/fire10"]
@onready var player = $".."

@export var AK_ORIG_NODE = Node3D
@export var PISTOL_ORIG_NODE = Node3D
@export var SNIPER_ORIG_NODE = Node3D
@export var SAIGA_ORIG_NODE = Node3D


func skip_weapon_cd(time : float):
	if !can_skip_weapon:
		can_skip_weapon = true
		await get_tree().create_timer(time, false).timeout
		can_skip_weapon = false

func _process(delta):
	reload()
	shoot()
	#AIM
	if Input.is_action_pressed("rc") and !cycle_aim_anim and _Inventory_Manager.current_weapon != "" and !AK_ORIG_NODE.reloadnig and !PISTOL_ORIG_NODE.reloadnig and _Inventory_Manager.current_weapon != "geyger" and !SNIPER_ORIG_NODE.reloadnig and player.moving == false:
		is_aim = true
		camera.fov = lerp(camera.fov, 40.0, delta * 5.0)
		if _Inventory_Manager.current_weapon == "AK-74":
			_State_Machine_Component.state = _State_Machine_Component.states.AIM_A
		elif _Inventory_Manager.current_weapon == "pistol":
			_State_Machine_Component.state = _State_Machine_Component.states.AIM_P
		elif  _Inventory_Manager.current_weapon == "sniper-samopal":
			_State_Machine_Component.state = _State_Machine_Component.states.AIM_S
		player.mouse_sens = 0.02
		await get_tree().create_timer(0.15, false).timeout
		cycle_aim_anim = true
	
	elif !Input.is_action_pressed("rc") and cycle_aim_anim:
		camera.fov = lerp(camera.fov, 65.0, delta * 5.0)
		if is_aim:
			is_aim = false
			player.mouse_sens = 0.05
			await get_tree().create_timer(0.15, false).timeout
			cycle_aim_anim = false

func shoot():
	if Input.is_action_pressed("lc"):
		if _Inventory_Manager.weapon_in_hand and !shooting:
			if _Inventory_Manager.current_weapon == "AK-74" and _Inventory_Manager.ammo5_45.size() > 0:
				if AK_ORIG_NODE.ammo > 0 and !AK_ORIG_NODE.reloadnig:
					smoke_part.emitting = true
					_Inventory_Manager.deleting = false
					player.can_run = false
					shooting = true
					_Sound_Component.ak_sounds[0].play()
					AK_ORIG_NODE.ammo -= 1
					_State_Machine_Component.ak_animator.play("Rig|AK_Shot")
					_State_Machine_Component.ak_animator.play("gilza")
					shoot_cd = 0.1
					player.kickback(0.001, -0.002, 0.02, 0.001)
					player.camera_shake_func(0.0005, 0.001)
					shoot_func("_body")
					for i in fires_AK:
						i.rotation.z = randi_range(1, 360)
						i.show()
					await get_tree().create_timer(shoot_cd, false).timeout
					for i in fires_AK:
						i.hide()
					shooting = false
				else:
					_Inventory_Manager.delate_ammo_5_45()
					if _Inventory_Manager.ammo5_45.size() > 0:
						_State_Machine_Component.state = _State_Machine_Component.states.RELOADING_A
						AK_ORIG_NODE.ammo_reload()
			elif _Inventory_Manager.current_weapon == "pistol" and _Inventory_Manager.ammo9_19.size() > 0:
				if PISTOL_ORIG_NODE.ammo > 0 and !PISTOL_ORIG_NODE.reloadnig:
					_Inventory_Manager.deleting = false
					player.can_run = false
					shooting = true
					$"../ARMS_CAM_POS/pistol_cam_pos/pistol_aim_pos/pistol_arms/Sketchfab_model/3ab9f780f2294ec8ba398c31f25c6b54_fbx/Object_2/RootNode/Armature/sound/shoot".play()
					PISTOL_ORIG_NODE.ammo -= 1
					_State_Machine_Component.pistol_animator.play("Armature|FPS_Pistol_Fire")
					shoot_cd = 0.2
					player.kickback(0.001, -0.002, 0.01, 0.0001)
					player.camera_shake_func(0.0005, 0.0005)
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
					_Inventory_Manager.delate_ammo_9_19()
					if _Inventory_Manager.ammo9_19.size() > 0:
						_State_Machine_Component.state = _State_Machine_Component.states.RELOADING_P
						PISTOL_ORIG_NODE.ammo_reload()
						
			elif _Inventory_Manager.current_weapon == "sniper-samopal" and _Inventory_Manager.ammo7_62.size() > 0:
				if SNIPER_ORIG_NODE.ammo > 0 and !SNIPER_ORIG_NODE.reloadnig:
					_Inventory_Manager.deleting = false
					player.can_run = false
					shooting = true
					sniper_shoot_sound_func()
					SNIPER_ORIG_NODE.ammo -= 1
					_State_Machine_Component.sniper_animator.play("Rig|SRifle_Shot_nosight")
					shoot_cd = 1.8
					player.kickback(0.001, -0.002, 0.03, 0.001)
					player.camera_shake_func(0.008, 0.008)
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
					_Inventory_Manager.delate_ammo_7_62()
					if _Inventory_Manager.ammo7_62.size() > 0:
						_State_Machine_Component.state = _State_Machine_Component.states.RELOADING_S
						SNIPER_ORIG_NODE.ammo_reload()
			elif _Inventory_Manager.current_weapon == "saiga" and _Inventory_Manager.ammo9_19.size() > 0:
				if SAIGA_ORIG_NODE.ammo > 0 and !SAIGA_ORIG_NODE.reloadnig:
					_Inventory_Manager.deleting = false
					player.can_run = false
					shooting = true
					_State_Machine_Component.saiga_animator.play("Rig|Saiga_Fire")
					_State_Machine_Component.saiga_animator.play("gilza")
					SAIGA_ORIG_NODE.ammo -= 1
					shoot_cd = 0.6
					player.kickback(0.001, -0.001, 0.02, 0.01)
					player.camera_shake_func(0.0005, 0.0009)
					shoot_func("_body")
					_Sound_Component.saiga_sounds[0].play()
					$"../ARMS_CAM_POS/saiga_cam_pos/saiga_aim_pos/saiga_arms/Sketchfab_model/95ac79517a844ea1b13875322aa37f27_fbx/Object_2/RootNode/Rig/Object_6/Skeleton3D/BoneAttachment3D/GPUParticles3D".emitting = true
					await get_tree().create_timer(shoot_cd, false).timeout
					shooting = false
				else:
					_Inventory_Manager.delate_ammo_9_19()
					if _Inventory_Manager.ammo9_19.size() > 0:
						_State_Machine_Component.state = _State_Machine_Component.states.RELOADING_SAI
						SAIGA_ORIG_NODE.ammo_reload()
						
func shoot_func(_body):
	if _Inventory_Manager.current_weapon == "AK-74":
		#add_traser(AK_collider)
		if AK_collider.is_colliding():
			if AK_collider.get_collider() is Hitbox:
				_body = AK_collider.get_collider()
				_body.activation(true, 5)
			else:
				decal_add(AK_collider)
	elif _Inventory_Manager.current_weapon == "pistol":
		if PISTOL_collider.is_colliding():
			if PISTOL_collider.get_collider() is Hitbox:
				_body = PISTOL_collider.get_collider()
				_body.activation(true, 2)
			else:
				decal_add(PISTOL_collider)
	elif _Inventory_Manager.current_weapon == "sniper-samopal":
		if SNIPER_collider.is_colliding():
			if SNIPER_collider.get_collider() is Hitbox:
				_body = SNIPER_collider.get_collider()
				_body.activation(true, 50)
			else:
				decal_add(SNIPER_collider)
	elif _Inventory_Manager.current_weapon == "saiga":
		if SAIGA_collider.is_colliding():
			if SAIGA_collider.get_collider() is Hitbox:
				_body = SAIGA_collider.get_collider()
				_body.activation(true, 7)
			else:
				decal_add(saiga_collider)

#func add_traser(col : RayCast3D):
	#var scene = get_tree().root
	#var b = traser.instantiate()
	#add_child(b)
	#b.reparent(scene)
	#b.global_position = col.global_position
	#b.global_rotation = camera.global_rotation
	
func decal_add(raycast : RayCast3D):
	var b = bullet_hole.instantiate()
	raycast.get_collider().add_child(b)
	b.global_transform.origin = raycast.get_collision_point()
	b.look_at(raycast.get_collision_point() + raycast.get_collision_normal(), Vector3.UP)
	b.rotate_object_local(Vector3(1,0,0), 90)

func reload():
	if Input.is_action_just_pressed("r"):
		if _Inventory_Manager.current_weapon == "AK-74" and !AK_ORIG_NODE.reloadnig and _Inventory_Manager.ammo5_45.size() > 1:
			_Inventory_Manager.delate_ammo_5_45()
			_Inventory_Manager.deleting = false
			_State_Machine_Component.state = _State_Machine_Component.states.RELOADING_A
			AK_ORIG_NODE.ammo_reload()
		elif _Inventory_Manager.current_weapon == "pistol" and !PISTOL_ORIG_NODE.reloadnig and _Inventory_Manager.ammo9_19.size() > 1:
			_Inventory_Manager.deleting = false
			_Inventory_Manager.delate_ammo_9_19()
			_State_Machine_Component.state = _State_Machine_Component.states.RELOADING_P
			PISTOL_ORIG_NODE.ammo_reload()
		elif _Inventory_Manager.current_weapon == "sniper-samopal" and !SNIPER_ORIG_NODE.reloadnig and _Inventory_Manager.ammo7_62.size() > 1:
			_Inventory_Manager.deleting = false
			_Inventory_Manager.delate_ammo_7_62()
			_State_Machine_Component.state = _State_Machine_Component.states.RELOADING_S
			SNIPER_ORIG_NODE.ammo_reload()
		elif _Inventory_Manager.current_weapon == "saiga" and !SAIGA_ORIG_NODE.reloadnig and _Inventory_Manager.ammo9_19.size() > 1:
			_Inventory_Manager.deleting = false
			_Inventory_Manager.delate_ammo_9_19()
			_State_Machine_Component.state = _State_Machine_Component.states.RELOADING_SAI
			SAIGA_ORIG_NODE.ammo_reload()

func sniper_shoot_sound_func():
	$"../ARMS_CAM_POS/sniper_cam_pos/sniper_aim_position/sniper_samopal_arms/shoot_sound".play()
	await get_tree().create_timer(0.2, false).timeout
	$"../ARMS_CAM_POS/sniper_cam_pos/sniper_aim_position/sniper_samopal_arms/zatvor_sound".play()
