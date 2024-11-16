extends RigidBody2D

@onready var area: Area2D = $Area2D

func _ready() -> void:
	area.body_entered.connect(destroy)
	
func destroy(body: CharacterBody2D) -> void:
	if body is Player: EventBus.player_died.emit()
