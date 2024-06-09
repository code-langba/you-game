extends Area2D

@export var game_over_scene: PackedScene

func _ready() -> void:
	self.body_entered.connect(dispose_node)

func dispose_node(_body: Node2D) -> void:
	PlayerManager.lives -= 1
	if PlayerManager.lives < 1:
		call_deferred("load_game_over")
		PlayerManager.reset()
		return
	call_deferred("reload")

func reload():
	get_tree().reload_current_scene()

func load_game_over() -> void:
	get_tree().change_scene_to_packed(game_over_scene)
