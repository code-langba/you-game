extends Area2D
class_name BounceComponent

@export var no_bounce: bool = false
@export var bounce_strength: float = 2000

func _ready() -> void:
	body_entered.connect(bounce)
	
func bounce(body: CharacterBody2D) -> void:
	if no_bounce: return
	$boing.play()
	body.velocity.y = -bounce_strength
