extends Control
signal resume
signal back_to_main_pressed

@onready var content : VBoxContainer = $%Content
@onready var options_menu : Control = $%OptionsMenu
@onready var resume_game_button: Button = $%ResumeGameButton

#var last_mouse_mode = Input.MOUSE_MODE_CAPTURED

func _ready():
	MenuTemplateManager.track_mouse_capture_context(self, false)

func open_pause_menu():
	# Stops game and shows pause menu
	show()
	resume_game_button.grab_focus()
	#last_mouse_mode = Input.mouse_mode
	#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func close_pause_menu():
	hide()
	emit_signal("resume")
	#Input.set_mouse_mode(last_mouse_mode)

func _on_resume_game_button_pressed():
	close_pause_menu()


func _on_options_button_pressed():
	content.hide()
	options_menu.show()
	options_menu.on_open()

func _on_options_menu_close():
	options_menu.hide()
	content.show()
	resume_game_button.grab_focus()

func _on_quit_button_pressed():
	get_tree().quit()

func _on_back_to_menu_button_pressed():
	close_pause_menu()
	GameManager.to_main_menu()

func _input(event):
	if (event.is_action_pressed("ui_cancel") or event.is_action_pressed("pause")) and visible and !options_menu.visible:
		accept_event()
		close_pause_menu()
