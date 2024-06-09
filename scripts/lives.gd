extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = str(PlayerManager.lives)
	PlayerManager.lives_changed.connect(update_lives)

func update_lives(lives) -> void:
	text = str(lives)


