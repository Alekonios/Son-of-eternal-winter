extends StaticBody3D

@export var item_name = "geyger"

var new_gun = null

func activation():
	queue_free()
