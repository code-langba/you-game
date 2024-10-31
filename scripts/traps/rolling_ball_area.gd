extends Area2D

@export var ball:RigidBody2D 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(func(_body): 
		ball.constant_force = Vector2(-1000,0)
		await get_tree().create_timer(10).timeout
		ball.queue_free()
		)
	pass # Replace with function body.
