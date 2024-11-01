extends Node2D


@export var bgm: AudioStream

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not AudioManager.is_playing:
		AudioManager.play(bgm)
