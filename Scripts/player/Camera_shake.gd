extends Camera3D

var shake = false

@export var player = CharacterBody3D

var is_run
var moving

func _process(delta):
	moving = player.moving
	is_run = player.is_run
	if !is_run and moving:
		camera_shake_on_walk()
	elif is_run and moving:
		camera_shake_on_run()
	

func camera_shake_on_walk():
	if shake:
		self.global_position.y -= 0.0015
		await get_tree().create_timer(0.2, false).timeout
		shake = false
	if !shake:
		self.global_position.y += 0.0015
		await get_tree().create_timer(0.2, false).timeout
		shake = true
		
func camera_shake_on_run():
	if shake:
		self.global_position.y -= 0.002
		await get_tree().create_timer(0.2, false).timeout
		shake = false
	if !shake:
		self.global_position.y += 0.002
		await get_tree().create_timer(0.2, false).timeout
		shake = true
