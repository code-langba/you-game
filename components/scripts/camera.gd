extends Node

@export var follow_camera: PhantomCamera2D
@onready var area_2d: Area2D = $Area2D
@onready var area_2d_2: Area2D = $Area2D2
@onready var area_2d_3: Area2D = $Area2D3

var default_bottom_limit: int = 1080

func _ready() -> void:
	area_2d.body_exited.connect(set_follow_camera_bounds.bind(area_2d, -475))
	area_2d_2.body_exited.connect(set_follow_camera_bounds.bind(area_2d_2, -475))
	area_2d_3.body_exited.connect(set_follow_camera_bounds.bind(area_2d_3, -122))
	
func set_follow_camera_bounds(body: Player, detector: Area2D, value: int) -> void:
	match detector:
		area_2d:
			if came_from(body, detector.global_position) == "right":
				follow_camera.limit_bottom = value
			else:
				follow_camera.limit_bottom = default_bottom_limit
		area_2d_2:
			if came_from(body, detector.global_position) == "right":
				follow_camera.limit_bottom = default_bottom_limit
			else:
				follow_camera.limit_bottom = value
		area_2d_3:
			if came_from(body, detector.global_position) == "right":
				follow_camera.limit_bottom = value
			else:
				follow_camera.limit_bottom = default_bottom_limit
				


func came_from(player: Player, detector_pos: Vector2) -> String:
	var direction =  player.global_position - detector_pos
	var _came_from = "left" if direction.normalized().x < 0 else "right"
	return _came_from
