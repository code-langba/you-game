class_name Checkpoint

extends Area2D

var is_active: bool = false

func _ready():
	body_entered.connect(trigger_checkpoint)

func trigger_checkpoint(_body: Node2D):
	if is_active:
		return
	$AnimationPlayer.play("blink")
	$ting.play()
	PlayerManager.current_checkpoint = global_position
	is_active = true
