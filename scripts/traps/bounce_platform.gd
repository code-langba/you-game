extends StaticBody2D

@export var bounce_height := 150.0
@export var bounce_force := 0.5

func _ready() -> void:
	$trigger.body_entered.connect(trigger_bounce)

func trigger_bounce(body: Player) -> void:
	# body.velocity.y = -bounce_force
	var tween = create_tween()
	tween.tween_property(body, "global_position:y", -bounce_height, bounce_force).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	
