extends Node
const OptionConstants = preload("res://addons/EasyMenus/Scripts/options_constants.gd")
const InputMapUpdater = preload("res://addons/EasyMenus/Scripts/input_map_updater.gd")

@onready var ControllerEchoInputGenerator = $ControllerEchoInputGenerator
@onready var startup_loader = $StartupLoader

# Called when the node enters the scene tree for the first time.
func _ready():
	InputMapUpdater.new()._ready()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# пока вот такой костыль, потом продумаю как блокировать импуты и прочее
enum MOUSE_CAPTYRE_TYPE {FORCE_MOUSE_CAPTURE, FORCE_MOUSE_RELEASE}
var mouse_capture_contexts = []

class MouseCaptureContextElement:
	extends RefCounted
	
	var type: MOUSE_CAPTYRE_TYPE
	var node: Node
	
	func _init(_node, _type):
		type = _type
		node = _node
		pass

func track_mouse_capture_context(_node: Node, _is_capturing: bool = false):
	var _type = MOUSE_CAPTYRE_TYPE.FORCE_MOUSE_CAPTURE if _is_capturing else MOUSE_CAPTYRE_TYPE.FORCE_MOUSE_RELEASE
	var _context = MouseCaptureContextElement.new(_node, _type)
	
	if _node.is_inside_tree() and _node.is_visible():
		mouse_capture_contexts.append(_context)
		_check_arr()
	
	#var _func = func(_node):
		#_node.visible
	
	_node.visibility_changed.connect(func():
		if _node.is_visible():
			mouse_capture_contexts.append(_context)
		else:
			mouse_capture_contexts.erase(_context)
		_check_arr()
		)
	_node.tree_exiting.connect(func():
		mouse_capture_contexts.erase(_context)
		_check_arr()
		)
	pass

func _check_arr():
	var _capture_check = false
	for element in mouse_capture_contexts:
		if element.type == MOUSE_CAPTYRE_TYPE.FORCE_MOUSE_RELEASE:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			return
		else:
			_capture_check = true
	if _capture_check:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

