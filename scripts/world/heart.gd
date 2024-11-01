extends Area2D

@export var health: int = 20
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(health, "asdsd")
	body_entered.connect(func(_body):
		PlayerManager.lives = PlayerManager.lives + health
		print('hello',PlayerManager.lives)
		queue_free()
		)
