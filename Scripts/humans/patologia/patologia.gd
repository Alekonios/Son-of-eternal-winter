extends CharacterBody3D

enum states { WARDER, IDLE, RUN, ATTACK }

@export var waypoints: Array[Marker3D]
@export var speed: float = 0.5
@export var idle_time: float = 2

var local_waypoints: Array[Marker3D] = []
var amount_of_way: int = 0
var get_way: Vector3
var number_way: int = 0
var accel: float = 10.0

var state: states = states.IDLE
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var animator = $patologia/AnimationPlayer
@onready var navigation_agent = $NavigationAgent3D
@onready var idle_timer = $IdleTimer


func _ready():
	for ways in waypoints:
		local_waypoints.push_back(ways)
	amount_of_way = len(local_waypoints) - 1
	idle_timer.wait_time = idle_time
	if amount_of_way < 0:
		print("ADD PATH!")
		self.queue_free()


func state_function(direction, delta):
	if state == states.WARDER:
		animator.play("walk")
		navigation_agent.target_position = get_way
		var position_point = navigation_agent.get_next_path_position()
		look_at(position_point)
		rotation = Vector3(0, rotation.y, 0)

		direction = navigation_agent.get_next_path_position() - global_position
		direction = direction.normalized()
		velocity = velocity.lerp(direction * speed, accel * delta)

		if self.global_position.distance_to(get_way) < 1.5:
			state = states.IDLE

	elif state == states.IDLE:
		velocity = Vector3.ZERO
		animator.play("Armature_001|mixamo_com|Layer0_001")
		if idle_timer.is_stopped():
			idle_timer.start()

	elif state == states.RUN:
		pass

	elif state == states.ATTACK:
		pass


func _physics_process(delta):
	get_way = local_waypoints[number_way].global_position

	velocity.y -= gravity * delta

	var direction = Vector3()

	state_function(direction, delta)

	move_and_slide()


func _on_idle_timer_timeout():
	number_way += 1
	if number_way > amount_of_way:
		number_way = 0
	state = states.WARDER
