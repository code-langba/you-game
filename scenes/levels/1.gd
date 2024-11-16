extends Node2D

@export var bgm: AudioStream
@export_group("Change only from parent scene")
@export var mouse_mode: Input.MouseMode = Input.MOUSE_MODE_VISIBLE
	
func _ready() -> void:
	Input.mouse_mode = mouse_mode
	if not AudioManager.is_playing:
		AudioManager.play(bgm)
		
	
