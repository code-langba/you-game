extends Node2D

@export var bgm: AudioStream
@export_group("Change only from parent scene")
@export var mouse_mode: Input.MouseMode = Input.MOUSE_MODE_VISIBLE
@export var bg_color: Color
	
func _ready() -> void:
	if bg_color: 
		RenderingServer.set_default_clear_color(bg_color)
	Input.mouse_mode = mouse_mode
	if not AudioManager.is_playing:
		AudioManager.play(bgm)
		
	
