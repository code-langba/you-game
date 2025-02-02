extends ParallaxLayer

@export var cloud_speed: float = 1

func _physics_process(delta: float) -> void:
	motion_offset.x -= cloud_speed
