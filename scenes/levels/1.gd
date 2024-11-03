extends Node2D


@export var bgm: AudioStream

func _ready() -> void:
	if not AudioManager.is_playing:
		AudioManager.play(bgm)
