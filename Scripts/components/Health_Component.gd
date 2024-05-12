extends Node3D

@export var player : Player

var HP = 100

@onready var blood_levels = [$level, $level2, $level3, $level4, $level5, $level6, $level7, $level8, $level9]

func hit():
	player.camera_shake_func(0.03)

func _on_health_timer_update_timeout():
	if HP < 90:
		$AnimationPlayer.play("blood_merc")
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
		$Health_Timer_update.stop()
		$AnimationPlayer.play("died")
		Engine.time_scale = 0.1
