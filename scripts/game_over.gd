extends Control

@export var main_menu_scene: PackedScene
@export var buttons: Array[Button]

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	buttons[0].grab_focus()
	for button in buttons:
		button.pressed.connect(on_button_pressed.bind(button))

func on_button_pressed(button: Button) -> void:
	match (button.get_meta("action")):
		"restart_level": get_tree().reload_current_scene()
		"go_to_main_menu": get_tree().change_scene_to_packed(main_menu_scene)
		"quit": get_tree().quit()
