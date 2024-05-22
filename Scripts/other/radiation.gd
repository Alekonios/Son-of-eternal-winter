extends StaticBody3D

@onready var high_radiation_zon = $high_radiation
@onready var middle_radiation_zon = $middle_radiation
@onready var small_radiation_zon = $small_radiation
@export var higt_radiation_zone_count : float
@export var middle_radiation_zone_count : float
@export var small_radiation_zone_count : float

@onready var damage_timer = $damage_timer
var damage_time
var in_rad = false

var enemy 

var high_rad = false
var middle_rad = false
var small_rad = false
var object
var rad_level = 3
var geyger

func _on_high_radiation_area_entered(area):
	if area is Hitbox:
		enemy = area
		damage_time = 0.8
		in_rad = true
		_on_damage_timer_timeout()
		damage_timer.start()
		object = area.get_parent()
		if object.is_in_group("player"):
			geyger = object.GEYGER_ORIG_NODE
			geyger.high_rad = true
func _on_high_radiation_area_exited(area):
	if area is Hitbox:
		in_rad = false
		object = area.get_parent()
		if object.is_in_group("player"):
			geyger = object.GEYGER_ORIG_NODE
			geyger.high_rad = false

func _on_middle_radiation_area_entered(area):
	if area is Hitbox:
		enemy = area
		damage_time = 1
		in_rad = true
		_on_damage_timer_timeout()
		damage_timer.start()
		object = area.get_parent()
		if object.is_in_group("player"):
			geyger = object.GEYGER_ORIG_NODE
			geyger.middle_rad = true
func _on_middle_radiation_area_exited(area):
	if area is Hitbox:
		in_rad = false
		object = area.get_parent()
		if object.is_in_group("player"):
			geyger = object.GEYGER_ORIG_NODE
			geyger.middle_rad = false
				
func _on_small_radiation_area_entered(area):
	if area is Hitbox:
		enemy = area
		damage_time = 2
		_on_damage_timer_timeout()
		in_rad = true
		damage_timer.start()
		object = area.get_parent()
		if object.is_in_group("player"):
			geyger = object.GEYGER_ORIG_NODE
			geyger.low_rad = true
func _on_small_radiation_area_exited(area):
	if area is Hitbox:
		in_rad = false
		object = area.get_parent()
		if object.is_in_group("player"):
			geyger = object.GEYGER_ORIG_NODE
			geyger.low_rad = false
			

		
func _on_damage_timer_timeout():
	print("иди")
	damage_timer.start()
	damage_timer.wait_time = damage_time
	if in_rad:
		if object._Inventory_Manager.gas_mask_on_helmet == false:
			enemy.activation(true, 5)
		damage_timer.start()
	else:
		damage_timer.stop()
