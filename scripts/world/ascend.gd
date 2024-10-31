extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(ascend_player)
	pass # Replace with function body.

func ascend_player(_body:Node2D):
	EventBus.ascend.emit()