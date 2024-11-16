extends Resource
class_name WitchResource

@export var gravity: float = 1000

@export_enum("LEFT:-1", "RIGHT:1") var throw_direction: int = -1

## This is the delay between attacks. The higher the slower.
@export_range(0, 5, 0.1, "or_greater", "suffix: secs") var attack_delay: float = 1

## Positive aims up while negative aims down.
@export_range(-1, 1, 0.1) var throw_trajectory_y: float = 0.2

@export var throw_force: float = 1000
