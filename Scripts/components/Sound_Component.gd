class_name Sound_Component

extends Node3D

var step_sound_playing = false

var damage_sound_plauing = false

@export var _Imventory_manager : Inventory_Manager

@onready var ak_sounds = [$"../ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/sounds/shoot_sound", $"../ARMS_CAM_POS/ak_aim_pos/ARMS/ak-74_arms/sounds/reload_sound"]
@onready var pistol_sounds = [$"../ARMS_CAM_POS/pistol_cam_pos/pistol_aim_pos/pistol_arms/Sketchfab_model/3ab9f780f2294ec8ba398c31f25c6b54_fbx/Object_2/RootNode/Armature/sound/shoot", $"../ARMS_CAM_POS/pistol_cam_pos/pistol_aim_pos/pistol_arms/Sketchfab_model/3ab9f780f2294ec8ba398c31f25c6b54_fbx/Object_2/RootNode/Armature/sound/reload", $"../ARMS_CAM_POS/pistol_cam_pos/pistol_aim_pos/pistol_arms/Sketchfab_model/3ab9f780f2294ec8ba398c31f25c6b54_fbx/Object_2/RootNode/Armature/sound/mag1", $"../ARMS_CAM_POS/pistol_cam_pos/pistol_aim_pos/pistol_arms/Sketchfab_model/3ab9f780f2294ec8ba398c31f25c6b54_fbx/Object_2/RootNode/Armature/sound/mag2"]
@onready var geyger_sounds = [$"../ARMS_CAM_POS/geyger_cam_pos/geiger_arms/Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/BoneAttachment3D/sounds/middle", $"../ARMS_CAM_POS/geyger_cam_pos/geiger_arms/Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/BoneAttachment3D/sounds/low", $"../ARMS_CAM_POS/geyger_cam_pos/geiger_arms/Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/BoneAttachment3D/sounds/high", $"../ARMS_CAM_POS/geyger_cam_pos/geiger_arms/Sketchfab_model/810f0276179d4425a118b331d5f38189_fbx/Object_2/RootNode/Rig/Object_8/Skeleton3D/BoneAttachment3D/sounds/not_have"]
@onready var sniper_sounds = [$"../ARMS_CAM_POS/sniper_cam_pos/sniper_aim_position/sniper_samopal_arms/shoot_sound", $"../ARMS_CAM_POS/sniper_cam_pos/sniper_aim_position/sniper_samopal_arms/zatvor_sound", $"../ARMS_CAM_POS/sniper_cam_pos/sniper_aim_position/sniper_samopal_arms/magaz_out", $"../ARMS_CAM_POS/sniper_cam_pos/sniper_aim_position/sniper_samopal_arms/magaz_up", $"../ARMS_CAM_POS/sniper_cam_pos/sniper_aim_position/sniper_samopal_arms/zatvor_out", $"../ARMS_CAM_POS/sniper_cam_pos/sniper_aim_position/sniper_samopal_arms/zatvor_up"]
@onready var say_sounds = [$"../sounds/voice_sound/pisk"]
@onready var step_sounds = [$"../sounds/steps_sound/snow_steps/step_sound", $"../sounds/steps_sound/snow_steps/step_sound2", $"../sounds/steps_sound/snow_steps/step_sound3", $"../sounds/steps_sound/snow_steps/step_sound4"]
@onready var player_env_sounds = [$"../sounds/voice_sound/gas_vzdoh"]
@onready var damage_sounds = [$"../sounds/voice_sound/damage_sound", $"../sounds/voice_sound/damage_sound2", $"../sounds/voice_sound/damage_sound3"]

func step_snow_sounds_walk():
	if !step_sound_playing:
		step_sound_playing = true
		var random_index = randi() % step_sounds.size()
		step_sounds[random_index].play()
		await get_tree().create_timer(0.5, false).timeout
		step_sound_playing = false
		
func step_snow_sounds_run():
	if !step_sound_playing:
		step_sound_playing = true
		var random_index = randi() % step_sounds.size()
		step_sounds[random_index].play()
		await get_tree().create_timer(0.3, false).timeout
		step_sound_playing = false
		
func anti_gas_sound():
	if !player_env_sounds[0].playing:
		player_env_sounds[0].play()
		
func damage_sounds_func():
	if !damage_sound_plauing:
		damage_sound_plauing = true
		var random_index = randi() % damage_sounds.size()
		damage_sounds[random_index].play()
		await get_tree().create_timer(0.25)
		damage_sound_plauing = false

func _on_timer_timeout():
	if _Imventory_manager.gas_mask_on_helmet:
		anti_gas_sound()
