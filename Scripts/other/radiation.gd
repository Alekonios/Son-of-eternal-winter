extends StaticBody3D

@onready var high_radiation_zon = $high_radiation
@onready var middle_radiation_zon = $middle_radiation
@onready var small_radiation_zon = $small_radiation
@export var higt_radiation_zone_count : float
@export var middle_radiation_zone_count : float
@export var small_radiation_zone_count : float
var high_rad = false
var middle_rad = false
var small_rad = false
var object
var rad_level = 3
var geyger

func _on_high_radiation_area_entered(area):
	if area is Hitbox:
		object = area.get_parent()
		if object.is_in_group("player"):
			geyger = object.GEYGER_ORIG_NODE
			geyger.high_rad = true
func _on_high_radiation_area_exited(area):
	if area is Hitbox:
		object = area.get_parent()
		if object.is_in_group("player"):
			geyger = object.GEYGER_ORIG_NODE
			geyger.high_rad = false

func _on_middle_radiation_area_entered(area):
	if area is Hitbox:
		object = area.get_parent()
		if object.is_in_group("player"):
			geyger = object.GEYGER_ORIG_NODE
			geyger.middle_rad = true
func _on_middle_radiation_area_exited(area):
	if area is Hitbox:
		object = area.get_parent()
		if object.is_in_group("player"):
			geyger = object.GEYGER_ORIG_NODE
			geyger.middle_rad = false
				
func _on_small_radiation_area_entered(area):
	if area is Hitbox:
		object = area.get_parent()
		if object.is_in_group("player"):
			geyger = object.GEYGER_ORIG_NODE
			geyger.low_rad = true
func _on_small_radiation_area_exited(area):
	if area is Hitbox:
		object = area.get_parent()
		if object.is_in_group("player"):
			geyger = object.GEYGER_ORIG_NODE
			geyger.low_rad = false
	
	
