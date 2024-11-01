extends Control

@export var bgm: AudioStream
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var manager = AudioManager
	if not manager.is_playing:
		manager.play(bgm)
		manager.is_playing = false
	%Button.pressed.connect(start_game)

func start_game() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/1.tscn")
