class_name settings

extends Control
@onready var choice_set = $choice_set
@onready var graphic_set = $graphic_set
@onready var but = $graphic_set/set_cont/HBoxContainer/VBoxContainer/OptionButton

func _ready():
	pass
func _on_graphic_pressed():
	choice_set.hide()
	graphic_set.show()
	
func _on_option_button_item_selected(index):
	set_msaa("msaa_3d", index)

func set_msaa(mode, index):
	match index:
		0:
			get_viewport().set(mode,Viewport.MSAA_DISABLED)
		1:
			get_viewport().set(mode,Viewport.MSAA_2X)
		2:
			get_viewport().set(mode,Viewport.MSAA_4X)
		3:
			get_viewport().set(mode,Viewport.MSAA_8X)
