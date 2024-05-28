
extends Node

#const config_file_name: String = "user://options.cfg"
@onready var config: ConfigFile = ConfigFile.new()

func _ready() -> void:
	var is_file_exists = FileAccess.file_exists(OptionsConstants.config_file_name)
	
	if is_file_exists:
		var err = config.load(OptionsConstants.config_file_name)
		return
	
	#config.save(OptionsConstants.config_file_name)


func save_options_value(section_name:String,  key: String, value: Variant) -> void:
	config.set_value(section_name, key, value)
	config.save(OptionsConstants.config_file_name)


func load_options_value(section_name:String,  key: String, _default = null) -> Variant:
	return config.get_value(section_name, key, _default)
