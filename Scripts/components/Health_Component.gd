extends Node3D

@export var player : Player



var HP = 100

@export var _Inventory_Manager = Inventory_Manager
@onready var blood_levels = [$level, $level2, $level3, $level4, $level5, $level6, $level7, $level8, $level9]
@export var sound_component : Sound_Component

func hit():
	$AnimationPlayer2.play("hit")
	sound_component.damage_sounds_func()
	player.camera_shake_func(0.001, 0.002)
	

func _on_health_timer_update_timeout():
	if HP < 90:
		$AnimationPlayer2.play("blood_merc")
		blood_levels[0].show()
	if HP < 80:
		blood_levels[1].show()
	if HP < 70:
		blood_levels[2].show()
	if HP < 60:
		blood_levels[3].show()
	if HP < 50:
		blood_levels[4].show()
	if HP < 40:
		blood_levels[5].show()
	if HP < 30:
		blood_levels[6].show()
	if HP < 20:
		blood_levels[7].show()
	if HP < 10:
		blood_levels[8].show()
	if HP < 0:
		sound_component.say_sounds[0].play()
		$Health_Timer_update.stop()
		$Control.show()
		$Control2.show()
		$AnimationPlayer2.play("died")
		Engine.time_scale = 0.1
