class_name SubViewportComponent

extends SubViewportContainer

var show_cd = false

@export var _Inventory_Manager : Inventory_Manager

@onready var ak_ammo_label = $"../ak_control/akko_ammo"
@onready var pistol_ammo_label = $"../pistol_control/pistol_ammo"
@onready var ak_animator = $"../ak_control/AnimationPlayer"
@onready var pistol_animator = $"../pistol_control/AnimationPlayer"
@onready var sniper_animator = $"../sniper_control/AnimationPlayer"
@onready var body_animator = $"../body/AnimationPlayer"
@onready var ak_contol = $"../ak_control"
@onready var pistol_control = $"../pistol_control"
@onready var sniper_control = $"../sniper_control"
@onready var body_control = $"../body"


@onready var player = $".."

func _input(event):
	if Input.is_action_just_pressed("t") and !show_cd:
		control_vis()
		body_control.show()
		body_animator.play("vis_on")
		await get_tree().create_timer(3, false).timeout
		body_animator.play("vis_of")
		await get_tree().create_timer(0.5, false).timeout
		body_control.hide()
func control_vis():
	if _Inventory_Manager.current_weapon == "AK-74":
		if !show_cd:
			ak_contol.show()
			ak_ammo_label.text = str(_Inventory_Manager.ammo5_45.size())
			show_cd = true
			ak_animator.play("vis_on")
			await get_tree().create_timer(3, false).timeout
			ak_animator.play("vis_of")
			await get_tree().create_timer(0.5, false).timeout
			ak_contol.hide()
			show_cd = false
	elif _Inventory_Manager.current_weapon == "pistol":
		if !show_cd:
			pistol_control.show()
			pistol_ammo_label.text = str(_Inventory_Manager.ammo9_19.size())
			show_cd = true
			pistol_animator.play("vis_on")
			await get_tree().create_timer(3, false).timeout
			pistol_animator.play("vis_of")
			await get_tree().create_timer(0.5, false).timeout
			pistol_control.hide()
			show_cd = false
	elif _Inventory_Manager.current_weapon == "sniper-samopal":
		if !show_cd:
			sniper_control.show()
			$"../sniper_control/sniper_ammo".text = str(_Inventory_Manager.ammo7_62.size())
			show_cd = true
			sniper_animator.play("vis_on")
			await get_tree().create_timer(3, false).timeout
			sniper_animator.play("vis_of")
			await get_tree().create_timer(0.5, false).timeout
			pistol_control.hide()
			show_cd = false
