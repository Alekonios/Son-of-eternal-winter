extends StaticBody3D

@export var gun_name = "ammo-7.62"

var new_gun = null

func activation():
	queue_free()
