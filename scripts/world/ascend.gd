extends Area2D

@export var ascend_bgm: AudioStream
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(ascend_player)

func ascend_player(_body:Node2D):
	AudioManager.is_playing = false
	EventBus.ascend.emit()
	create_tween().tween_property(AudioManager.audio, 'volume_db', -20, 2)
	await get_tree().create_timer(2).timeout
	create_tween().tween_property(AudioManager.audio, 'volume_db', 0, 0.5)
	AudioManager.play(ascend_bgm)
