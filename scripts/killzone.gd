extends Area2D

func _ready() -> void:
	self.body_entered.connect(kill)

func kill(body: CharacterBody2D) -> void:
	if body is Player: 
		EventBus.player_died.emit()
	else:
		body.queue_free()
