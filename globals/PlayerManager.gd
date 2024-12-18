extends Node

var follow_camera_pos: Vector2
var current_checkpoint: Vector2
var lives := 10:
	set(value):
		lives = clamp(value, 0, 20)
		EventBus.lives_changed.emit(lives)

func reset_checkpoint() -> void:
	current_checkpoint = Vector2.ZERO

func reset() -> void:
	reset_checkpoint()
	lives = 10
