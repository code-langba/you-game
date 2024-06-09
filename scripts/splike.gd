extends Node2D

@onready var trigger:Area2D = $trigger

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	trigger.body_entered.connect(trigger_spike)

func trigger_spike(_body: Node2D) -> void:
	var killzone:Area2D = $killzone
	create_tween().tween_property(killzone, "position:y", -128, 0.15)
