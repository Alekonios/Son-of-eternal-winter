extends Node3D
var reloadnig = false
var ammo = 5
@onready var animator = $AnimationPlayer

func ammo_reload():
	if !reloadnig:
		reloadnig = true
		print("начал перезарядку")
		play_reload_sound()
		await get_tree().create_timer(5, false).timeout
		ammo = 5
		reloadnig = false
		print("закончил перезарядку")

func play_reload_sound():
	await get_tree().create_timer(0.3, false).timeout
	$zatvor_out.play()
	await get_tree().create_timer(1.3, false).timeout
	$magaz_out.play()
	await get_tree().create_timer(1.5, false).timeout
	$magaz_up.play()
	await get_tree().create_timer(0.9, false).timeout
	$zatvor_up.play()
	
	
	
