extends Camera3D

@export var main_cam_path: NodePath
@onready var main_cam = get_node(main_cam_path)


func _process(delta):
	self.global_transform = main_cam.global_transform
