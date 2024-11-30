extends Node

@onready var audio: AudioStreamPlayer2D = $Audio

var is_playing = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func play(song:AudioStream):
	audio.stream = song
	audio.play()
	is_playing = true
	pass

func stop():
	audio.stop()
