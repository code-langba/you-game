extends Area2D

func _ready() -> void:
	body_entered.connect(func(_body): 
		$Sprite2D.play("wiggle")
		$grass_sfx.play()
		)
