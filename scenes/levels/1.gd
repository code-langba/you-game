extends Node2D

@export var bgm: AudioStream
@export var game_over_scene: PackedScene
@export_group("Change only from parent scene")
@export var mouse_mode: Input.MouseMode = Input.MOUSE_MODE_VISIBLE
@export var bg_color: Color
@onready var ui: CanvasLayer = $Ui
@onready var initial_camera: PhantomCamera2D = $Camera/InitialCamera

func _ready() -> void:
	set_mouse_mode()
	if bg_color: 
		RenderingServer.set_default_clear_color(bg_color)
	if not AudioManager.is_playing:
		AudioManager.play(bgm)
	EventBus.game_over.connect(on_game_over)
		
func on_game_over() -> void:
	var game_over_node = game_over_scene.instantiate()
	ui.add_child(game_over_node)

func set_mouse_mode() -> void:
	Input.mouse_mode = mouse_mode
