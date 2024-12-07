extends RigidBody2D
class_name RollingBall

@onready var area: Area2D = $Area2D
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	area.body_entered.connect(destroy)
	
func destroy(body: CharacterBody2D) -> void:
	if body is Player: EventBus.player_died.emit()
