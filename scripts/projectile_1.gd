extends RigidBody2D

@onready var collider: Area2D = $Collider

func _ready() -> void:
	collider.body_entered.connect(destroy)
	
func destroy(body: Node2D) -> void:
	if body is Player: 
		body.knockback()
		queue_free()
	else: 
		await get_tree().create_timer(1).timeout
		queue_free()
