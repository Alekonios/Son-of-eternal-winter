extends Node3D

var reloadnig = false
var ammo = 13
@onready var animator = $AnimationPlayer

func ammo_reload():
	if !reloadnig:
		reloadnig = true
		print("начал перезарядку")
		play_reload_sound()
		await get_tree().create_timer(1.65, false).timeout
		ammo = 13
		reloadnig = false
		print("закончил перезарядку")

func play_reload_sound():
	await get_tree().create_timer(0.2, false).timeout
	$"Sketchfab_model/3ab9f780f2294ec8ba398c31f25c6b54_fbx/Object_2/RootNode/Armature/sound/mag1".play()
	await get_tree().create_timer(0.9, false).timeout
	$"Sketchfab_model/3ab9f780f2294ec8ba398c31f25c6b54_fbx/Object_2/RootNode/Armature/sound/mag2".play()
	await get_tree().create_timer(0.3, false).timeout
	$"Sketchfab_model/3ab9f780f2294ec8ba398c31f25c6b54_fbx/Object_2/RootNode/Armature/sound/reload".play()
	
	
