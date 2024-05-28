extends Control
signal start_game_pressed

@onready var start_game_button: Button = $%StartGameButton
@onready var options_menu: Control = $%OptionsMenu
@onready var content: Control = $%Content 
@onready var network_connection_menu = $NetworkConnectionMenu

#var _instance_button = SoundManager.instance()

func _ready():
	GlobalSoundBank.play_rand("lobby")
	start_game_button.grab_focus()
	connect("start_game_pressed", open_network_connection_menu)
	
	#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	MenuTemplateManager.track_mouse_capture_context(self, false)
	if multiplayer.multiplayer_peer:
		multiplayer.multiplayer_peer.close()

func quit():
	SoundManager.play("button", "beep")
	get_tree().quit()

func open_options():
	SoundManager.play("button", "beep")
	options_menu.show()
	content.hide()
	options_menu.on_open()

func open_network_connection_menu():
	network_connection_menu.show()
	options_menu.hide()
	content.hide()

func close_network_connection_menu():
	network_connection_menu.hide()
	content.show()

func close_options():
	content.show();
	start_game_button.grab_focus()
	options_menu.hide()

func _on_start_game_button_pressed():
	SoundManager.play("button", "beep")
	emit_signal("start_game_pressed")
