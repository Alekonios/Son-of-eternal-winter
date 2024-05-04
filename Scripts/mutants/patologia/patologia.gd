extends CharacterBody3D

enum states { WARDER, IDLE, RUN, ATTACK, AGRESOR }

@export var waypoints: Array[Marker3D]
@export var run_speed: float = 1.5
@export var warder_speed: float = 0.5
@export var idle_time: float = 2

var targed_area: Hitbox
var last_visible_position: Vector3

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
	if state == states.WARDER and !died:
		if targed_area == null: animator.play("walk_new")
		else: animator.play("new_run")
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

	elif state == states.IDLE and !died:
		velocity = Vector3.ZERO
		animator.play("Armature_001|mixamo_com|Layer0_001")
		if idle_timer.is_stopped():
			idle_timer.start()

	elif state == states.AGRESOR and !died and !agresor_anim:
		velocity = Vector3.ZERO
		looked_at()
		if !animator.current_animation == "wizg":
			animator.play("wizg")
			await get_tree().create_timer(3, false).timeout
			state = states.WARDER
			agresor_anim = true
			
			

func looked_at():
	var a = Quaternion(transform.basis)
	var po = navigation_agent.get_next_path_position()
	po.y = transform.origin.y
	var b = Quaternion(transform.looking_at(po, Vector3.UP).basis)
	var c = a.slerp(b, 0.2)
	transform.basis = Basis(c)

func _physics_process(delta):
	if died: return
	if targed_area != null: 
		get_way = targed_area.global_position
		speed = run_speed
	else: 
		get_way = local_waypoints[number_way].global_position
		speed = warder_speed

	velocity.y -= gravity * delta * 3
	var direction = Vector3()

	state_function(direction, delta)
	move_and_slide()


func _on_idle_timer_timeout():
	number_way += 1
	if number_way > amount_of_way:
		number_way = 0
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
		animator.play("wizg")
	
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
