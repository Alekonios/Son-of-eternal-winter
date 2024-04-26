extends StaticBody3D

@export var gun_name = "ammo-5.45"

var new_gun = null

func activation():
	queue_free()
