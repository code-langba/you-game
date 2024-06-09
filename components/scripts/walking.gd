class_name WalkComponent

extends Node2D

@onready var raycast: RayCast2D = $RayCast2D

func walk(velocity: Vector2, direction: float, _scale: Vector2, speed: float) -> Array:
	velocity.x = direction * speed
	if raycast.is_colliding():
		_scale.x *= -1
		direction *= -1
	return [velocity, direction, _scale]
