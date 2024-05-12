extends Node3D

@export var _Inventory_Manager : Inventory_Manager

@onready var strelka = $"Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/BoneAttachment3D/geiger/Cube_002"
@onready var player = $"../../.."

var not_have_Drad = true
var high_rad = false
var middle_rad = false
var low_rad = false

@onready var sounds = [$"Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/BoneAttachment3D/sounds/middle", $"Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/BoneAttachment3D/sounds/low", $"Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/BoneAttachment3D/sounds/high", $"Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/BoneAttachment3D/sounds/not_have"]

@onready var strelka_anim = $AnimationPlayer2

func geyger_state_change():
	if _Inventory_Manager.current_weapon == "geyger":
		if high_rad and middle_rad and low_rad:
			high_rad_sound_func()
			strelka_anim.play("high_rad")
		elif middle_rad and low_rad and !high_rad:
			middle_rad_sound_func()
			strelka_anim.play("middle_rad")
		elif low_rad and !high_rad and !middle_rad:
			strelka_anim.play("low_rad")
			low_rad_sound_func()
		elif !low_rad and !high_rad and !middle_rad:
			nothave_rad_sound_func()
			strelka_anim.play("not_have_rad")
	
func _process(delta):
	geyger_state_change()
	
func low_rad_sound_func():
	if !sounds[1].playing:
		sounds[1].play()
func middle_rad_sound_func():
	if !sounds[0].playing:
		sounds[0].play()
func high_rad_sound_func():
	if !sounds[2].playing:
		sounds[2].play()
func nothave_rad_sound_func():
	if !sounds[3].playing:
		sounds[3].play()
	

	
