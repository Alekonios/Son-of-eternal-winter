extends Node3D

var reloadnig = false
var ammo = 10
@onready var animator = $AnimationPlayer

func ammo_reload():
	if !reloadnig:
		reloadnig = true
		play_reload_sound()
		await get_tree().create_timer(4.3, false).timeout
		ammo = 10
		reloadnig = false

func play_reload_sound():
	await get_tree().create_timer(0.9, false).timeout
	$sounds/mag_out.play()
	await get_tree().create_timer(1.25, false).timeout
	$sounds/mag_on.play()
	await get_tree().create_timer(1.25, false).timeout
	$sounds/zatik_back.play()
	await get_tree().create_timer(0.2, false).timeout
	$sounds/zatik_forward.play()
	
