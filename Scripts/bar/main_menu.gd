extends Node3D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$"1_person/AnimationPlayer".play("stat_idle")
