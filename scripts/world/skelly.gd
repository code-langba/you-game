extends Area2D

@onready var label:Label = $Label
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.visible = false
	body_entered.connect(func(_body): label.visible = true)
