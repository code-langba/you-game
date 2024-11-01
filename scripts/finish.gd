extends Area2D

@export var next_level: PackedScene
@onready var world = owner.get_parent()

func _ready() -> void:
	body_entered.connect(on_level_complete)

func on_level_complete(_body: Node2D) -> void:
	PlayerManager.reset_checkpoint()
	AudioManager.stop()
	AudioManager.is_playing = false
	call_deferred("load_next_level")

func load_next_level():
	get_tree().change_scene_to_packed(next_level)

