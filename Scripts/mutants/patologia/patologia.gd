extends CharacterBody3D

enum states { WARDER, IDLE, RUN, ATTACK, AGRESOR }

@export var waypoints: Array[Marker3D]
@export var run_speed: float = 5.0
@export var warder_speed: float = 1.0
@export var idle_time: float = 2
@export var max_walk_time: float = 20

@onready var blood_part = $GPUParticles3D
@onready var attack_collider = $RayCast3D

var targed_area: Hitbox
var last_visible_position: Vector3

var current_attack_num = 0
var scary = false
var speed: float
var HP = 100
var died = false
var action = false
var agresor_anim = false
var local_waypoints: Array[Marker3D] = []
var amount_of_way: int = 0
var get_way: Vector3
var number_way: int = 0
var accel: float = 10.0
var attacking = false
var damage_enemy = false
var step_sound_playing = false
@onready var step_sounds = [$snow_steps/step_sound, $snow_steps/step_sound2, $snow_steps/step_sound3, $snow_steps/step_sound4]

var state: states = states.IDLE
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var animator = $patologia/AnimationPlayer
@onready var navigation_agent = $NavigationAgent3D
@onready var idle_timer = $IdleTimer
@onready var walk_timer = $WalkTimer


func _ready():
	for ways in waypoints:
		local_waypoints.push_back(ways)
	amount_of_way = len(local_waypoints) - 1
	idle_timer.wait_time = idle_time
	if amount_of_way < 0:
		self.queue_free()

func _physics_process(delta):
	check_attack_collider("enemy")
	if died: return
	if targed_area != null: 
		get_way = targed_area.global_position
		speed = run_speed
	elif targed_area == null and scary:
		get_way = local_waypoints[number_way].global_position
		speed = run_speed
	elif targed_area == null: 
		get_way = local_waypoints[number_way].global_position
		speed = warder_speed

	velocity.y -= gravity * delta * 3
	var direction = Vector3()

	state_function(direction, delta)
	move_and_slide()

func state_function(direction, delta):
	if state == states.WARDER:
		if !died and !attacking and animator.current_animation != "attack1" and animator.current_animation != "wizg" and animator.current_animation != "attack3" and !animator.current_animation == "attack4":
			attack_collider.target_position.z = -0.3
			if targed_area == null and !scary:
				animator.play("walk_new")
				step_snow_sounds_walk()
				if walk_timer.is_stopped():
					walk_timer.start()
			elif targed_area == null and scary:
				animator.play("new_run")
				step_snow_sounds_run()
				if walk_timer.is_stopped():
					walk_timer.start()
			elif targed_area != null:
				step_snow_sounds_run()
				animator.play("new_run")
			navigation_agent.target_position = get_way
			var position_point = navigation_agent.get_next_path_position()
			looked_at()
			rotation = Vector3(0, rotation.y, 0)

			direction = navigation_agent.get_next_path_position() - global_position
			direction = direction.normalized()
			velocity = velocity.lerp(direction * speed, accel * delta)

		if self.global_position.distance_to(get_way) < 1.5:
			if targed_area == null: state = states.IDLE
			elif targed_area != null: pass

	elif state == states.IDLE:
		if !died and !attacking:
			velocity = Vector3.ZERO
			animator.play("Armature_001|mixamo_com|Layer0_001")
			if idle_timer.is_stopped():
				idle_timer.start()

	elif state == states.AGRESOR:
		if !died and !agresor_anim:
			velocity = Vector3.ZERO
			looked_at()
			if !animator.current_animation == "wizg":
				animator.play("wizg")
				$wizg.play()
				await get_tree().create_timer(2.5, false).timeout
				state = states.WARDER
				agresor_anim = true
	elif state == states.ATTACK:
		if current_attack_num == 0 and !animator.current_animation == "attack3":
			if !died and attacking:
				attack_collider.target_position.z = -1.5
				velocity = Vector3.ZERO
				animator.play("attack1")
				if animator.current_animation == "attack1":
					await get_tree().create_timer(1.8, false).timeout
					current_attack_num = 1
					attacking = false
					state = states.WARDER
		elif current_attack_num == 1 and !animator.current_animation == "attack1":
			if !died and attacking:
					attack_collider.target_position.z = -1.5
					velocity = Vector3.ZERO
					animator.play("attack3")
					if animator.current_animation == "attack3":
						await get_tree().create_timer(1.8, false).timeout
						current_attack_num = 2
						attacking = false
						state = states.WARDER
		elif current_attack_num == 2 and !animator.current_animation == "attack4":
			if !died and attacking:
					attack_collider.target_position.z = -2.0
					velocity = Vector3.ZERO
					animator.play("attack4")
					if animator.current_animation == "attack4":
						await get_tree().create_timer(2.9, false).timeout
						current_attack_num = 0
						attacking = false
						state = states.WARDER

func looked_at():
	if !attacking:
		var a = Quaternion(transform.basis)
		var po = navigation_agent.get_next_path_position()
		po.y = transform.origin.y
		var b = Quaternion(transform.looking_at(po, Vector3.UP).basis)
		var c = a.slerp(b, 0.2)
		transform.basis = Basis(c)

func _on_idle_timer_timeout():
	var random_index = randi_range(0, amount_of_way)
	number_way = random_index
	if number_way > amount_of_way:
		number_way = 0
	else:
		state = states.WARDER

func _on_wardering_area_3d_area_entered(area: Hitbox):
	if !targed_area:
		$WarderingBigArea3D2.monitoring = true
		targed_area = area
		state = states.AGRESOR

func _on_wardering_area_3d_area_exited(_area: Hitbox):
	pass
	
func hit():
	if !died:
		blood_part.emitting = true
		walk_timer.stop()
		idle_timer.stop()
		if !targed_area:
			random_dir()
	
func _on_died_timer_timeout():
	if HP <= 0:
		$DiedTimer.stop()
		animator.play("died")
		died = true

func _on_wardering_big_area_3d_2_area_entered(_area : Hitbox):
	pass # Replace with function body.

func _on_wardering_big_area_3d_2_area_exited(_area : Hitbox):
	$WarderingBigArea3D2.monitoring = false
	agresor_anim = false
	targed_area = null

func _on_walk_timer_timeout():
	var random_time = randi_range(1, 20)
	walk_timer.wait_time = random_time
	print("ss")
	state = states.IDLE
	scary = false

func random_dir():
	scary = true
	walk_timer.wait_time = 20
	print("ss")
	var random_index = randi_range(0, amount_of_way)
	number_way = random_index
	state = states.WARDER
	
func check_attack_collider(enemy):
	if attack_collider.is_colliding() and attack_collider.get_collider() is Hitbox and !attacking:
		enemy = attack_collider.get_collider()
		attacking = true
		state = states.ATTACK

func damage_enemy_func(enemy):
	if attack_collider.is_colliding() and attack_collider.get_collider() is Hitbox and !damage_enemy:
		damage_enemy = true
		enemy = attack_collider.get_collider()
		enemy.activation(true, 20)
		await get_tree().create_timer(0.1, false).timeout
		damage_enemy = false
	
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
	
	
