class_name State_Machine_Component

extends Node3D

enum states {IDLE, WALK, RUN, AIM_A, IDLE_A, WALK_A, RUN_A, SHOOT_A, RELOADING_A, AIM_P, IDLE_P, WALK_P, RUN_P, SHOOT_P, RELOADING_P, IDLE_GE, WALK_GE, RUN_GE, IDLE_S, WALK_S, RUN_S, AIM_S, SHOOT_S, RELOADING_S, IDLE_SAI, WALK_SAI, RUN_SAI, AIM_SAI, SHOOT_SAI, RELOADING_SAI}

@export var _Weapon_Manager : Weapon_Manager
@export var _Inventory_Manager : Inventory_Manager
@export var player : Player
@export var animator : AnimationPlayer
@export var ak_animator : AnimationPlayer
@export var pistol_animator : AnimationPlayer
@export var sniper_animator : AnimationPlayer
@export var geyger_animator : AnimationPlayer
@export var saiga_animator : AnimationPlayer

@onready var camera = $"../camera_node"

@onready var AK_ARMS_CAM_POS = $"../ARMS_CAM_POS"
@onready var AK_ORIG_NODE = $"../ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms"
@onready var PISTOL_ORIG_NODE = $"../ARMS_CAM_POS/pistol_cam_pos/pistol_aim_pos/pistol_arms"
@onready var GEYGER_ORIG_NODE = $"../ARMS_CAM_POS/geyger_cam_pos/geiger_arms"
@onready var SNIPER_ORIG_NODE = $"../ARMS_CAM_POS/sniper_cam_pos/sniper_aim_position/sniper_samopal_arms"
@onready var SAIGA_ORIG_NODE =$"../ARMS_CAM_POS/saiga_cam_pos/saiga_aim_pos/saiga_arms"

@onready var AK_ARMS_CAM_POS_AIM = $"../ARMS_CAM_POS/ak_aim_pos"
@onready var PISTOL_ARMS_CAM_POS = $"../ARMS_CAM_POS/pistol_cam_pos"
@onready var PISTOL_CAM_POS_AIM = $"../ARMS_CAM_POS/pistol_cam_pos/pistol_aim_pos"
@onready var SNIPER_ARMS_CAM_POS = $"../ARMS_CAM_POS/sniper_cam_pos"
@onready var SNIPER_CAM_POS_AIM = $"../ARMS_CAM_POS/sniper_cam_pos/sniper_aim_position"
@onready var GEYGER_CAM_POS = $"../ARMS_CAM_POS/geyger_cam_pos"
@onready var SAIGA_ARMS_CAM_POS = $"../ARMS_CAM_POS/saiga_cam_pos"
@onready var SAIGA_CAM_POS_AIM = $"../ARMS_CAM_POS/saiga_cam_pos/saiga_aim_pos"
@onready var ARMS = $"../ARMS_CAM_POS/ak_aim_pos/ARMS"

var speed
@export var state : states = states.IDLE


		
func _process(delta):
	print(saiga_animator.current_animation)
	speed = player.speed
	match state:
		states.IDLE:
			animator.play("stat_idle")

		states.WALK:
			animator.play("STAT-idle")
			player.speed = 1.0

		states.RUN:
			animator.play("run")
			player.speed = 2.0

		states.IDLE_A:
			animator.play("idle with automat")
			ak_animator.play("Rig|AK_Idle")

		states.WALK_A:
			animator.play("walk with automat")
			ak_animator.play("Rig|AK_Walk")
			player.speed = 1.0

		states.RUN_A:
			player.speed = 2.0
			animator.play("run with automat 2")
			ak_animator.play("Rig|AK_Run")

		states.AIM_A:
			animator.play("idle with automat")
			ak_animator.play("Rig|AK_Idle")

		states.RELOADING_A:
			player.speed = 1.0
			ak_animator.play("Rig|AK_Reload_full")

		states.WALK_P:
			player.speed = 1.0
			pistol_animator.play("Armature|FPS_Pistol_Walk")

		states.RUN_P:
			player.speed = 2.0
			pistol_animator.play("Armature|FPS_Pistol_Walk")

		states.IDLE_P:
			pistol_animator.play("Armature|FPS_Pistol_Idle")

		states.AIM_P:
			pistol_animator.play("Armature|FPS_Pistol_Idle")

		states.RELOADING_P:
			player.speed = 1.0
			pistol_animator.play("Armature|FPS_Pistol_Reload_full")

		states.IDLE_GE:
			geyger_animator.play("geiger_idle")

		states.WALK_GE:
			geyger_animator.play("geyger_walk")
			player.speed = 1.0

		states.IDLE_S:
			if !sniper_animator.current_animation == "Rig|SRifle_Shot_nosight":
				sniper_animator.play("Rig|SRifle_Idle")

		states.WALK_S:
			player.speed = 1.0
			if sniper_animator.current_animation != "Rig|SRifle_Shot_nosight":
				sniper_animator.play("Rig|SRifle_Walk")

		states.RUN_S:
			player.speed = 1.2
			sniper_animator.play("Rig|SRifle_Walk")
		
		states.RELOADING_S:
			sniper_animator.play("Rig|SRifle_Reload_Full")
			
		states.IDLE_SAI:
			if saiga_animator.current_animation != "Rig|Saiga_Fire":
				saiga_animator.play("Rig|Saiga_Idle")
			
		states.WALK_SAI:
			player.speed = 0.9
			if saiga_animator.current_animation != "Rig|Saiga_Fire":
				saiga_animator.play("Rig|Saiga_Walk")
		
		states.RUN_SAI:
			player.speed = 1.8
			saiga_animator.play("Rig|Saiga_Run")
		
		states.AIM_SAI:
			saiga_animator.play("Rig|Saiga_Idle")
		
		states.RELOADING_SAI:
			saiga_animator.play("Rig|Saiga_Reload_Full")
			
	states_logics()

func states_logics():
	if _Weapon_Manager.is_aim == false and _Inventory_Manager.current_weapon == "AK-74":
		AK_ARMS_CAM_POS.rotation.x = -camera.rotation.x
		AK_ARMS_CAM_POS_AIM.rotation.x = 0
		GEYGER_CAM_POS.rotation.x = 0
		SNIPER_ARMS_CAM_POS.rotation.x = 0
		SAIGA_ARMS_CAM_POS.rotation.x = 0
		SNIPER_CAM_POS_AIM.rotation.x = 0
	elif _Weapon_Manager.is_aim == true and _Inventory_Manager.current_weapon == "AK-74":
		AK_ARMS_CAM_POS_AIM.rotation.x = -camera.rotation.x
		AK_ARMS_CAM_POS.rotation.x = 0
		GEYGER_CAM_POS.rotation.x = 0
	elif _Weapon_Manager.is_aim == false and _Inventory_Manager.current_weapon == "pistol":
		SNIPER_CAM_POS_AIM.rotation.x = 0
		AK_ARMS_CAM_POS.rotation.x = 0
		PISTOL_CAM_POS_AIM.rotation.x = 0
		GEYGER_CAM_POS.rotation.x = 0
		SNIPER_ARMS_CAM_POS.rotation.x = 0
		SAIGA_ARMS_CAM_POS.rotation.x = 0
		PISTOL_ARMS_CAM_POS.rotation.x = -camera.rotation.x
	elif _Weapon_Manager.is_aim == true and _Inventory_Manager.current_weapon == "pistol":
		PISTOL_ARMS_CAM_POS.rotation.x = 0
		GEYGER_CAM_POS.rotation.x = 0
		PISTOL_CAM_POS_AIM.rotation.x = -camera.rotation.x
	elif _Weapon_Manager.is_aim == false and _Inventory_Manager.current_weapon == "sniper-samopal":
		AK_ARMS_CAM_POS.rotation.x = 0
		PISTOL_CAM_POS_AIM.rotation.x = 0
		GEYGER_CAM_POS.rotation.x = 0
		PISTOL_ARMS_CAM_POS.rotation.x = 0
		SNIPER_CAM_POS_AIM.rotation.x = 0
		SAIGA_ARMS_CAM_POS.rotation.x = 0
		SNIPER_ARMS_CAM_POS.rotation.x = -camera.rotation.x
	elif _Weapon_Manager.is_aim and _Inventory_Manager.current_weapon == "sniper-samopal":
		SNIPER_ARMS_CAM_POS.rotation.x = 0
		SNIPER_CAM_POS_AIM.rotation.x = -camera.rotation.x
	elif _Inventory_Manager.current_weapon == "geyger":
		SNIPER_ARMS_CAM_POS.rotation.x = 0
		AK_ARMS_CAM_POS.rotation.x = 0
		PISTOL_ARMS_CAM_POS.rotation.x = 0
		SAIGA_ARMS_CAM_POS.rotation.x = 0
		GEYGER_CAM_POS.rotation.x = -camera.rotation.x
	elif _Weapon_Manager.is_aim == false and _Inventory_Manager.current_weapon == "saiga":
		SNIPER_ARMS_CAM_POS.rotation.x = 0
		AK_ARMS_CAM_POS.rotation.x = 0
		PISTOL_ARMS_CAM_POS.rotation.x = 0
		SAIGA_CAM_POS_AIM.rotation.x = 0
		SAIGA_ARMS_CAM_POS.rotation.x = -camera.rotation.x
	elif _Weapon_Manager.is_aim and _Inventory_Manager.current_weapon == "saiga":
		SAIGA_ARMS_CAM_POS.rotation.x = 0
		SAIGA_CAM_POS_AIM.rotation.x = -camera.rotation.x
		
	elif _Weapon_Manager.is_aim == false and _Inventory_Manager.current_weapon != "AK-74":
		ARMS.rotation.x = 0
	elif _Weapon_Manager.is_aim == false and _Inventory_Manager.current_weapon != "pistol":
		ARMS.rotation.x = 0

