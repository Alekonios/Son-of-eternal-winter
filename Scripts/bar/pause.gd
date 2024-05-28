extends Control
@onready var options_menu =  $OptionsMenu
@onready var content = $VBoxContainer
@onready var pause_label = $Label

func _on_options_pressed():
	pause_label.hide()
	options_menu.show()
	content.hide()
	options_menu.on_open()


func _on_back_button_pressed():
	pause_label.show()
	content.show()
	options_menu.hide()
	
func _input(event):
	if Input.is_action_just_pressed("esc"):
		if get_tree().paused == false:
			Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
			get_tree().paused = true
			self.show()
		elif get_tree().paused == true:
			get_tree().paused = false
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			self.hide()


func _on_resume_pressed():
	if get_tree().paused == true:
			get_tree().paused = false
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			self.hide()
