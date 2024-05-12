class_name Interpolate_Component

extends Node3D

@export var State_Machine : State_Machine_Component
var state
var states
@export var camera : Camera3D
@onready var cam_origin = [$"../cam_positions/def_positions/def_position", $"../cam_positions/def_positions/walk_position", $"../cam_positions/def_positions/run_position", $"../cam_positions/AK_positions/ak_def_position", $"../cam_positions/AK_positions/ak_walk_position", $"../cam_positions/AK_positions/ak_run_position", $"../cam_positions/AK_positions/ak_aim", $"../cam_positions/pistol_positions/pistol_def_position", $"../cam_positions/pistol_positions/pistol_walk", $"../cam_positions/pistol_positions/pistol_run", $"../cam_positions/pistol_positions/pistol_aim", $"../cam_positions/sniper_positions/sniper_def_position", $"../cam_positions/sniper_positions/sniper_walk_position", $"../cam_positions/sniper_positions/sniper_run_position", $"../cam_positions/sniper_positions/sniper_aim_position"]
												#0												#1										#2												#3													#4												#5												#6										#7														#8														#9													#10												#11																#12														#13														#14									
func _process(delta):
	state = State_Machine.state
	states = State_Machine.states
	if state == states.IDLE:
		camera.global_position = lerp(camera.global_position, cam_origin[3].global_position, delta * 5)
	elif state == states.WALK:
		camera.global_position = lerp(camera.global_position, cam_origin[4].global_position, delta * 5)
	elif state == states.RUN: 
		camera.global_position= lerp(camera.global_position, cam_origin[5].global_position, delta * 5)
	elif state == states.IDLE_A:
		camera.global_position= lerp(camera.global_position, cam_origin[3].global_position, delta * 5)
	elif state == states.WALK_A:
		camera.global_position= lerp(camera.global_position, cam_origin[4].global_position, delta * 5)
	elif state == states.RUN_A:
		camera.global_position= lerp(camera.global_position, cam_origin[5].global_position, delta * 5)
	elif state == states.AIM_A:
		camera.global_position= lerp(camera.global_position, cam_origin[6].global_position, delta * 10)
	elif state == states.RELOADING_A:
		camera.global_position= lerp(camera.global_position, cam_origin[0].global_position, delta * 5)
	elif state == states.WALK_P:
		camera.global_position= lerp(camera.global_position, cam_origin[8].global_position, delta * 5)
	elif state == states.RUN_P:
		camera.global_position= lerp(camera.global_position, cam_origin[9].global_position, delta * 5)
	elif state == states.IDLE_P:
		camera.global_position= lerp(camera.global_position, cam_origin[7].global_position, delta * 10)
	elif state == states.AIM_P:
		camera.global_position= lerp(camera.global_position, cam_origin[10].global_position, delta * 5)
	elif state == states.RELOADING_P:
		camera.global_position= lerp(camera.global_position, cam_origin[0].global_position, delta * 5)
	elif state == states.IDLE_GE:
		camera.global_position= lerp(camera.global_position, cam_origin[3].global_position, delta * 5)
	elif state == states.WALK_GE:
		camera.global_position= lerp(camera.global_position, cam_origin[4].global_position, delta * 5)
	elif state == states.IDLE_S:
		camera.global_position= lerp(camera.global_position, cam_origin[11].global_position, delta * 5)
	elif state == states.WALK_S:
		if state != states.AIM_S:
			camera.global_position= lerp(camera.global_position, cam_origin[12].global_position, delta * 5)
		else:
			camera.global_position= lerp(camera.global_position, cam_origin[14].global_position, delta * 5)
	elif state == states.RUN_S:
		camera.global_position= lerp(camera.global_position, cam_origin[13].global_position, delta * 5)
	elif state == states.AIM_S:
		camera.global_position= lerp(camera.global_position, cam_origin[14].global_position, delta * 5)
	elif state == states.RELOADING_S:
		camera.global_position= lerp(camera.global_position, cam_origin[11].global_position, delta * 5)

	
