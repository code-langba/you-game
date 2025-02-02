extends Area2D
class_name CameraZoneDetector

@export var disabled: bool = false
@export var camera_container: Node
@export var prev_camera: PhantomCamera2D
@export var next_camera: PhantomCamera2D
@export var player: Player

var current_camera: PhantomCamera2D
var cameras: Array

func _ready() -> void:
	body_entered.connect(change_camera_on_entered)
	body_exited.connect(change_camera_on_exit)
	if disabled: return
	
func change_camera_on_entered(body: Player) -> void:
	if disabled: return
	
	var direction =  body.global_position - global_position 
	# detect if player entered area from left or right
	var came_from = "left" if direction.normalized().x < 0 else "right" 
	# switch to next camera
	if came_from == "left":
		if current_camera and current_camera.get_instance_id() == next_camera.get_instance_id(): return
		reset_camera_priority()
		current_camera = next_camera
		next_camera.priority = 1
	# switch to previous camera
	if came_from == "right":
		if current_camera and current_camera.get_instance_id() == prev_camera.get_instance_id(): return
		reset_camera_priority()
		current_camera = prev_camera
		prev_camera.priority = 1

func change_camera_on_exit(body: Player) -> void:
	if disabled: return
	
	var direction = global_position - body.global_position 
	var came_from = "left" if direction.normalized().x < 0 else "right"
	if came_from == "left":
		if current_camera and current_camera.get_instance_id() == next_camera.get_instance_id(): return
		reset_camera_priority()
		current_camera = next_camera
		next_camera.priority = 1
	if came_from == "right":
		if current_camera and current_camera.get_instance_id() == prev_camera.get_instance_id(): return
		reset_camera_priority()
		current_camera = prev_camera
		prev_camera.priority = 1
		
func reset_camera_priority() -> void:
	if not cameras: return
	for camera in (cameras as Array[PhantomCamera2D]):
		camera.priority = 0
