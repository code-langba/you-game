extends Node

@onready var audio: AudioStreamPlayer2D = $Audio

var is_playing = false

func play(song:AudioStream):
	audio.stream = song
	audio.play()
	is_playing = true

func stop():
	is_playing = false
	audio.stop()
