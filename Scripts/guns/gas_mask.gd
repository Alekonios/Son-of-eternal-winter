extends StaticBody3D

@export var item_name = "gas-mask"

var new_gun = null

func activation():
	queue_free()
