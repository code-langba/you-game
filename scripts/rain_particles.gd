extends GPUParticles2D

@export_range(0, 5, 0.1, "suffix: s") var particle_lifetime: float = 1
@export var particle_amount: int = 1000
@export var sound_distance: float = 2000

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	audio_stream_player_2d.max_distance = sound_distance
	lifetime = particle_lifetime
	amount = particle_amount
	emitting = true
	
