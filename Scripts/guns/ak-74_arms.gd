extends Node3D

var reloadnig = false
var ammo = 30
@onready var animator = $AnimationPlayer

func ammo_reload():
	if !reloadnig:
		reloadnig = true
		play_reload_sound()
		await get_tree().create_timer(3.5, false).timeout
		ammo = 30
		reloadnig = false

func play_reload_sound():
	await get_tree().create_timer(0.3, false).timeout
	$sounds/reload_sound.play()
	

	
	
	
