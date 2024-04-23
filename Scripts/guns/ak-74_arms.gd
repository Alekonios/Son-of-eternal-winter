extends Node3D

var reloadnig = false
var ammo = 30
@onready var animator = $AnimationPlayer

func ammo_reload():
	if !reloadnig:
		reloadnig = true
		print("начал перезарядку")
		await get_tree().create_timer(3.5, false).timeout
		ammo = 30
		reloadnig = false
		print("закончил перезарядку")

	
	
	
