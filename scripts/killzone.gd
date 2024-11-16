extends Area2D

func _ready() -> void:
	body_entered.connect(kill)
	
func kill(body: PhysicsBody2D) -> void:
	if body is Player: 
		EventBus.player_died.emit()
	else:
		body.queue_free()
