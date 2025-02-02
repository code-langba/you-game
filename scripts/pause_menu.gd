extends Control

@export var main_menu_scene: PackedScene
@export var buttons: Array[Button]
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer
const SETTINGS = preload("res://scenes/ui/settings.tscn")
var is_setting_open := false

func _ready() -> void:
	get_tree().paused = true
	#buttons[0].grab_focus()
	for button in buttons:
		button.pressed.connect(on_button_pressed.bind(button))
		button.mouse_entered.connect(on_mouse_entered.bind(button))
		button.focus_entered.connect(on_button_focus_entered.bind(button))

func _exit_tree() -> void:
	get_tree().paused = false

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST or what == NOTIFICATION_WM_GO_BACK_REQUEST:
		if not is_setting_open:
			queue_free()
		else: 
			var setting = get_child(-1)
			setting.queue_free()
			is_setting_open = false

func on_button_pressed(button: Button) -> void:
	match (button.get_meta("action")):
		"quit": get_tree().quit()
		"settings": 
			var settings_scene = SETTINGS.instantiate()
			add_child(settings_scene)
			is_setting_open = true
		"resume": queue_free()
		
func on_mouse_entered(button: Button) -> void:
	button.grab_focus()
	
func on_button_focus_entered(_button: Button) -> void:
	audio.play()
