extends Area2D

func _ready() -> void:
	self.body_entered.connect(func(_body): PlayerManager.player_died.emit())

