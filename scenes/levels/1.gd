extends Node2D

@export var bgm: AudioStream
@export var game_over_scene: PackedScene
@export var pause_menu_scene: PackedScene

@export_group("Change only from parent scene")
@export var bg_color: Color

@onready var ui: CanvasLayer = $Ui
@onready var initial_camera: PhantomCamera2D = $Camera/InitialCamera
@onready var fps: Label = $Ui/MarginContainer/HBoxContainer/Fps

var show_fps : bool = true
func _ready() -> void:
	if bg_color: 
		RenderingServer.set_default_clear_color(bg_color)
	if not AudioManager.is_playing:
		AudioManager.play(bgm)
	EventBus.game_over.connect(on_game_over)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("esc"):
		add_pause_menu_scene()
	if event.is_action_pressed("show_fps"):
		show_fps = !show_fps
		fps.visible = true if show_fps else false

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_GO_BACK_REQUEST or what == NOTIFICATION_WM_CLOSE_REQUEST:
		add_pause_menu_scene()

func _process(_delta: float) -> void:
	fps.text = str(Engine.get_frames_per_second())

func add_pause_menu_scene() -> void:
	var pause_menu = pause_menu_scene.instantiate()
	ui.add_child(pause_menu)

func on_game_over() -> void:
	var game_over_node = game_over_scene.instantiate()
	ui.add_child(game_over_node)
