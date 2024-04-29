class_name Hitbox

extends Area3D

@export var body = Node3D
@export var damagable : bool

func activation(_damagable : bool, damage_count: float):
	if _damagable == false and !damagable:
		body.activation()
	else:
		if damagable:
			body._damage = damage_count
			body.activation()
	
