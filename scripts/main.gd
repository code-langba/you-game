extends Control

@export var bgm: AudioStream
@export var buttons: Array[Button]
@onready var settings_packed_scene = preload("res://scenes/ui/settings.tscn")
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	get_tree().paused = false
	SceneManager.set_param(-0.1)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	var manager = AudioManager
	manager.play(bgm)
	EventBus.setting_close.connect(on_setting_close)
	# buttons
	buttons[0].grab_focus()
	connect_buttons()

func start_game() -> void:
	PlayerManager.reset()
	AudioManager.stop()
	SceneManager.change_scene_to_file("res://scenes/levels/1.tscn")
	
func quit_game() -> void:
	get_tree().quit()

func open_settings() -> void:
	var settings_scene = settings_packed_scene.instantiate()
	add_child(settings_scene)

func on_button_pressed(button: Button) -> void:
	hide_btns()
	match button.get_meta("action"):
		"start":
			print("start")
			start_game()
		"quit": 
			quit_game()
		"settings":
			open_settings()

func on_mouse_entered(button: Button) -> void:
	button.grab_focus()

func on_button_focus_entered(_button: Button) -> void:
	audio.play()

func connect_buttons() -> void:
	for button in buttons:
		button.focus_entered.connect(on_button_focus_entered.bind(button))
		button.mouse_entered.connect(on_mouse_entered.bind(button))
		button.pressed.connect(on_button_pressed.bind(button))
		
func disconnect_buttons() -> void:
	for button in buttons:
		button.focus_entered.disconnect(on_button_focus_entered.bind(button))
		button.mouse_entered.disconnect(on_mouse_entered.bind(button))
		button.pressed.disconnect(on_button_pressed.bind(button))
		
func hide_btns() -> void:
	for btn in buttons:
		btn.visible = false 
				
func show_btns() -> void:
	for btn in buttons:
		btn.visible = true 

func on_setting_close() -> void:
	buttons[0].grab_focus()
	#connect_buttons()
	show_btns()
