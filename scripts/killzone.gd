extends Area2D


func _ready() -> void:
	self.body_entered.connect(dispose_node)

func dispose_node(_body: Node2D) -> void:
	call_deferred("reload")

func reload():
	get_tree().reload_current_scene()
