extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(func(_body):
		PlayerManager.lives = PlayerManager.lives + 20
		print('hello',PlayerManager.lives)
		queue_free()
		)
