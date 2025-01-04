extends Label

func _ready() -> void:
	text = str(PlayerManager.lives)
	EventBus.lives_changed.connect(update_lives)

func update_lives(lives) -> void:
	text = str(lives)
