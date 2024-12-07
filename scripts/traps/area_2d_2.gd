extends Area2D

func _ready() -> void:
	body_entered.connect(func(body: RigidBody2D): 
		if body is RollingBall:
			body.audio.stop()
			queue_free()
	)
