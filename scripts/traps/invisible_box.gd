extends StaticBody2D

func _ready() -> void:
	var box = $hidden_sprite
	box.visible = false
	$trigger.body_entered.connect(func(_body): box.visible = true)
