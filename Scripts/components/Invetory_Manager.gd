class_name Inventory_Manager

extends Node3D

@export var Sound_component : Sound_Component

@onready var collider = $"../camera_node/Camera3D/RayCast3D"
@onready var player_2d = $"../SubViewportContainer"

@export var ak_animator : AnimationPlayer
@export var pistol_animator : AnimationPlayer
@export var geyger_animator : AnimationPlayer

@onready var AK_ARMS_CAM_POS = $"../ARMS_CAM_POS"
@onready var AK_ORIG_NODE = $"../ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms"
@onready var PISTOL_ORIG_NODE = $"../ARMS_CAM_POS/pistol_cam_pos/pistol_aim_pos/pistol_arms"
@onready var GEYGER_ORIG_NODE = $"../ARMS_CAM_POS/geyger_cam_pos/geiger_arms"
@onready var SNIPER_ORIG_NODE = $"../ARMS_CAM_POS/sniper_cam_pos/sniper_aim_position/sniper_samopal_arms"

@onready var AK_ARMS_CAM_POS_AIM = $"../ARMS_CAM_POS/ak_aim_pos"
@onready var PISTOL_ARMS_CAM_POS = $"../ARMS_CAM_POS/pistol_cam_pos"
@onready var PISTOL_CAM_POS_AIM = $"../ARMS_CAM_POS/pistol_cam_pos/pistol_aim_pos"
@onready var SNIPER_ARMS_CAM_POS = $"../ARMS_CAM_POS/sniper_cam_pos"
@onready var SNIPER_CAM_POS_AIM = $"../ARMS_CAM_POS/sniper_cam_pos/sniper_aim_position"
@onready var GEYGER_CAM_POS = $"../ARMS_CAM_POS/geyger_cam_pos"
@onready var ARMS = $"../ARMS_CAM_POS/ak_aim_pos/ARMS"

var ak_path = load("res://Scenes/Guns/AK-74.tscn")
var pistol_path = load("res://Scenes/Guns/pistol.tscn")
var sniper_path = load("res://Scenes/Guns/sniper_samopal.tscn")

var weapon_in_hand = false #эта пеменная отвечает так же и за предметы, не только оружия
var current_weapon = ""
var deleting = false
var can_skip_weapon = false
var gas_mask_on_helmet = false

var object = null
var weapons = [""]
var items = []
var ammo5_45 = []
var ammo9_19 = []
var ammo7_62 = []

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

func _ready():
	current_weapon = ""
	print(current_weapon)

func _input(event):
	if Input.is_action_just_pressed("e"):
		take_it("_body")
	if Input.is_action_just_pressed("c"):
		for i in items:
			if i == "geyger" and !current_weapon == "geyger":
				current_weapon = "geyger"
				geyger_animator.play("geiger draw")
				switch_item()
	if Input.is_action_just_pressed("z"):
		for i in items:
			if i == "gas-mask":
				if !gas_mask_on_helmet:
					gas_mask_on_helmet = true
					$"../gas_mask_text".show()
				else:
					gas_mask_on_helmet = false
					$"../gas_mask_text".hide()
	if Input.is_action_just_pressed("q"):
		drop()
		
	if Input.is_action_just_pressed("1") and current_weapon != weapons[0] and !AK_ORIG_NODE.reloadnig and !PISTOL_ORIG_NODE.reloadnig and !can_skip_weapon:
		switch_weapon(0)
	elif Input.is_action_just_pressed("2") and weapons.size() > 1 and current_weapon != weapons[1] and !AK_ORIG_NODE.reloadnig and !PISTOL_ORIG_NODE.reloadnig and !can_skip_weapon:
		switch_weapon(1)
	elif Input.is_action_just_pressed("3") and weapons.size() > 2 and current_weapon != weapons[2] and !AK_ORIG_NODE.reloadnig and !PISTOL_ORIG_NODE.reloadnig and !can_skip_weapon:
		switch_weapon(2)
	elif Input.is_action_just_pressed("4") and weapons.size() > 3 and current_weapon != weapons[3] and !AK_ORIG_NODE.reloadnig and !PISTOL_ORIG_NODE.reloadnig and !can_skip_weapon:
		switch_weapon(3)

func take_it(_body):
	if collider.is_colliding():
		if collider.get_collider() is Hitbox:
			_body = collider.get_collider()
			object = _body.get_parent()
			if object.is_in_group("weapon"):
				$"../sounds/big_item_take".play()
				weapons.push_back(object.gun_name)
				_body.activation(false, 0)
				weapon_in_hand = true
			elif object.is_in_group("item"):
				$"../sounds/big_item_take".play()
				items.push_back(object.item_name)
				_body.activation(false, 0)
			elif object.is_in_group("ammo"):
				$"../sounds/small_item_take".play()
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
		
func skip_weapon_cd(time : float):
	if !can_skip_weapon:
		can_skip_weapon = true
		await get_tree().create_timer(time, false).timeout
		can_skip_weapon = false
		
func drop():
	if current_weapon == "AK-74":
		var scene = get_tree().root
		weapons.find("AK-74")
		weapons.erase("AK-74")
		current_weapon = ""
		update_weapon_visuals()
		var ak_node = ak_path.instantiate()
		add_child(ak_node)
		ak_node.global_position = self.global_position
		ak_node.global_position.y += 0.5
		ak_node.global_rotation.z = 26
		ak_node.reparent(scene)
	elif current_weapon == "pistol":
		var scene = get_tree().root
		weapons.find("pistol")
		weapons.erase("pistol")
		current_weapon = ""
		update_weapon_visuals()
		var pistol_node = pistol_path.instantiate()
		add_child(pistol_node)
		pistol_node.global_position = self.global_position
		pistol_node.global_position.y += 0.5
		pistol_node.global_rotation.z = 26
		pistol_node.reparent(scene)
	elif current_weapon == "sniper-samopal":
		var scene = get_tree().root
		weapons.find("sniper-samopal")
		weapons.erase("sniper-samopal")
		current_weapon = ""
		update_weapon_visuals()
		var sniper_node = sniper_path.instantiate()
		add_child(sniper_node)
		sniper_node.global_position = self.global_position
		sniper_node.global_position.y += 0.5
		sniper_node.global_rotation.z = 26
		sniper_node.reparent(scene)
		
	
