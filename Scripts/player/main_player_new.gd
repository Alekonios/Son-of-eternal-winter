class_name Player_New

extends CharacterBody3D

@export var speed: float = 1.0
@export var jump: float = 2.0

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_pressed("shift") and Input.is_action_pressed("w"):
		is_run = true
	else:
		is_run = false

	if Input.is_action_just_pressed("space") and is_on_floor():
		velocity.y = jump * delta * 50

	var input_direction = Input.get_vector("d", "a", "s", "w")
	var direction = (transform.basis * Vector3(input_direction.x, 0, input_direction.y)).normalized()

	if input_direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		moving = true
		if !is_run and !current_weapon:
			state = states.WALK
		elif current_weapon == "AK-74":
			state = states.WALK_A
		if is_run:
			if !current_weapon:
				state = states.RUN
			elif current_weapon == "AK-74":
				state = states.RUN_A
				
	else:
		moving = false
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
		if !current_weapon:
			state = states.IDLE
		elif current_weapon == "AK-74":
			state = states.IDLE_A
		
	move_and_slide()
