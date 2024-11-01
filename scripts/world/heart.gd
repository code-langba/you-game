extends Area2D

@export var health: int = 20
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(func(_body):
		PlayerManager.lives = clamp(PlayerManager.lives + health, 1, 20)
		queue_free()
		)
