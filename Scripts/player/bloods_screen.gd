extends Control

@onready var blood_levels = [$"1_level_blood", $"2_level_blood", $"3_level_blood", $"4_level_blood", $"5_level_blood"]
@onready var player = $".."
var HP


func _on_check_player_hp_timeout():
	HP = player.HP
	blood_logic()
	
func blood_logic():
	if HP >= 100:
		for i in blood_levels:
			i.hide()
	if HP <= 90:
		blood_levels[0].show()
	if HP <= 70:
		blood_levels[1].show()
	if HP <= 50:
		blood_levels[2].show()
	if HP <= 30:
		blood_levels[3].show()
	if HP <= 15:
		blood_levels[3].show()
	
	
		
