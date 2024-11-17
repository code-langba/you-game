extends Control

@export var bgm: AudioStream
@export var buttons: Array[Button]
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	var manager = AudioManager
	if not manager.is_playing:
		manager.play(bgm)
		manager.is_playing = false
	
	# buttons
	buttons[0].grab_focus()
	for button in buttons:
		button.mouse_entered.connect(on_mouse_entered.bind(button))
		button.focus_entered.connect(on_button_focus_entered.bind(button))
		button.pressed.connect(on_button_pressed.bind(button))

func start_game() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/1.tscn")
	
func quit_game() -> void:
	get_tree().quit()

func open_settings() -> void:
	print_rich("[color=orange]Not Implemented[/color]")

func on_button_pressed(button: Button) -> void:
	match button.get_meta("action"):
		"start": start_game()
		"quit": quit_game()
		"settings": open_settings()

func on_mouse_entered(button: Button) -> void:
	button.grab_focus()

func on_button_focus_entered(_button: Button) -> void:
	audio.play()
