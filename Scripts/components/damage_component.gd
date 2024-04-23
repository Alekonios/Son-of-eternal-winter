class_name Damage_component

extends Node3D

@export var parent = Node3D
var _damage

func activation():
	set_damage(_damage)
	

func set_damage(damage : float):
	parent.HP -= damage
	parent.hit()
	
