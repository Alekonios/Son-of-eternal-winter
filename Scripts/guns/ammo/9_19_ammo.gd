extends StaticBody3D

@export var gun_name = "ammo-9.19"

var new_gun = null

func activation():
	queue_free()
