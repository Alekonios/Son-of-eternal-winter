extends SubViewportContainer

var show_cd = false
@onready var ak_ammo_label = $"../ak_control/akko_ammo"
@onready var pistol_ammo_label = $"../pistol_control/pistol_ammo"
@onready var ak_animator = $"../ak_control/AnimationPlayer"
@onready var pistol_animator = $"../pistol_control/AnimationPlayer"
@onready var ak_contol = $"../ak_control"
@onready var pistol_control = $"../pistol_control"

@onready var player = $".."

func _input(event):
	if Input.is_action_just_pressed("t"):
		control_vis()
func control_vis():
	if player.current_weapon == "AK-74":
		if !show_cd:
			ak_contol.show()
			ak_ammo_label.text = str(player.ammo5_45.size())
			show_cd = true
			ak_animator.play("vis_on")
			await get_tree().create_timer(3, false).timeout
			ak_animator.play("vis_of")
			await get_tree().create_timer(0.5, false).timeout
			ak_contol.hide()
			show_cd = false
	elif player.current_weapon == "pistol":
		if !show_cd:
			pistol_control.show()
			pistol_ammo_label.text = str(player.ammo9_19.size())
			show_cd = true
			pistol_animator.play("vis_on")
			await get_tree().create_timer(3, false).timeout
			pistol_animator.play("vis_of")
			await get_tree().create_timer(0.5, false).timeout
			pistol_control.hide()
			show_cd = false
			
				
