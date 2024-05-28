extends Node3D

@onready var options_menu =  $OptionsMenu
@onready var content = $VBoxContainer

# Called every frame. 'delta' is the elapsed time since the previous frame.



func _on_set_pressed():
	options_menu.show()
	content.hide()
	options_menu.on_open()


func _on_back_button_pressed():
	content.show()
	options_menu.hide()


func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/TEST/TEST.tscn")
