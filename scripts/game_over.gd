extends Control

@export var main_menu_scene: PackedScene
@export var buttons: Array[Button]
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	get_tree().paused = true
	buttons[1].grab_focus()
	for button in buttons:
		button.pressed.connect(on_button_pressed.bind(button))
		button.mouse_entered.connect(on_mouse_entered.bind(button))
		button.focus_entered.connect(on_button_focus_entered.bind(button))

func on_button_pressed(button: Button) -> void:
	match (button.get_meta("action")):
		"go_to_main_menu": get_tree().change_scene_to_packed(main_menu_scene)
		"quit": get_tree().quit()
		
func on_mouse_entered(button: Button) -> void:
	button.grab_focus()
	
func on_button_focus_entered(_button: Button) -> void:
	audio.play()
