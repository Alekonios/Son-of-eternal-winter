extends Camera3D

@onready var fps_rig_start_pos_x : Vector3
@onready var fps_rig_start_pos_y : Vector3
@export var main_cam_path: NodePath
@onready var main_cam = get_node(main_cam_path)
@onready var fps_rig = $"../../../ARMS_CAM_POS"

func _ready():
	fps_rig_start_pos_x.x = fps_rig.position.x
	fps_rig_start_pos_y.y = fps_rig.position.y

func _process(delta):
	self.global_transform = main_cam.global_transform
	fps_rig.position.x = lerp(fps_rig.position.x, fps_rig_start_pos_x.x, delta * 5)
	fps_rig.position.y = lerp(fps_rig.position.y, fps_rig_start_pos_y.y, delta * 5)
	
	
func sway(sway_amount):
	fps_rig.position.x += sway_amount.x * 0.0009
	fps_rig.position.y += sway_amount.y * 0.0009
