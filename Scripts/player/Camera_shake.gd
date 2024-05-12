extends Camera3D

var shake = false

@export var player = CharacterBody3D

var is_run
var moving

func _process(delta):
	moving = player.moving
	is_run = player.is_run
	if Input.is_action_pressed("a"):
		self.global_rotation.z = lerp(self.global_rotation.z, $"../../cam_positions/left_turn".global_rotation.z, delta * 15)
	elif Input.is_action_pressed("d"):
		self.global_rotation.z = lerp(self.global_rotation.z, $"../../cam_positions/right_turn".global_rotation.z, delta * 15)
	elif !Input.is_action_pressed("d") and !Input.is_action_pressed("a"):
		self.global_rotation.z = lerp(self.global_rotation.z, $"../../cam_positions/start_turn".global_rotation.z, delta * 15)
	if !is_run and moving:
		if shake:
			self.global_position.y -= 0.009 * delta * 5
			await get_tree().create_timer(0.2, false).timeout
			shake = false
		if !shake:
			self.global_position.y += 0.009 * delta * 5 
			await get_tree().create_timer(0.2, false).timeout
			shake = true
	elif is_run and moving:
		if shake:
			self.global_position.y -= 0.01 * delta * 5
			await get_tree().create_timer(0.15, false).timeout
			shake = false
		if !shake:
			self.global_position.y += 0.01 * delta * 5
			await get_tree().create_timer(0.15, false).timeout
			shake = true
			
	
