extends Node
class_name MovementComponent

@export var pause_movement: bool = false
@export var disable_gravity: bool = false

enum DIRECTIONS  {
	LEFT = -1,
	RIGHT = 1,
	STILL = 0
}

@export var raycast: RayCast2D
@export var direction: int = DIRECTIONS.RIGHT

func walk(body: CharacterBody2D, speed: float, _delta: float = 1) -> void:
	if !pause_movement:
		body.velocity.x = direction * speed * _delta
		if raycast and raycast.is_colliding():
			body.scale.x *= -1
			direction *= -1
	else:
		body.velocity.x = DIRECTIONS.STILL
	

func apply_gravity(body: CharacterBody2D, _delta: float = 1, gravity: float = 300) -> void:
	if not body.is_on_floor() and not disable_gravity:
		body.velocity.y += gravity * _delta
	
