extends Control

@export var main_menu_scene: PackedScene
@export var buttons: Array[Button]
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer
const SETTINGS = preload("res://scenes/ui/settings.tscn")

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().paused = true
	buttons[0].grab_focus()
	for button in buttons:
		button.pressed.connect(on_button_pressed.bind(button))
		button.mouse_entered.connect(on_mouse_entered.bind(button))
		button.focus_entered.connect(on_button_focus_entered.bind(button))

func _exit_tree() -> void:
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("esc"):
		queue_free()

func on_button_pressed(button: Button) -> void:
	match (button.get_meta("action")):
		"main_menu": get_tree().change_scene_to_packed(main_menu_scene)
		"settings": 
			var settings_scene = SETTINGS.instantiate()
			add_child(settings_scene)
		"resume": queue_free()
		
func on_mouse_entered(button: Button) -> void:
	button.grab_focus()
	
func on_button_focus_entered(_button: Button) -> void:
	audio.play()
