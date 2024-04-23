class_name Hitbox

extends Area3D

@export var body = Node3D

func activation(damagable : bool, damage_count: float):
	if damagable == false:
		body.activation()
	else:
		body._damage = damage_count
		body.activation()
	
