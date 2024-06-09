class_name Checkpoint

extends Area2D

func _ready():
	body_entered.connect(trigger_checkpoint)

func trigger_checkpoint(_body: Node2D):
	PlayerManager.current_checkpoint = global_position
