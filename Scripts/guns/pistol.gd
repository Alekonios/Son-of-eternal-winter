extends StaticBody3D

@export var gun_name = ""

var new_gun = null

func activation():
	queue_free()
