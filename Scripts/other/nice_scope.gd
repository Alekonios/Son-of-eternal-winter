extends Node3D

func _process(delta):
	$SubViewport/Camera3D.global_transform = $Marker3D.global_transform
