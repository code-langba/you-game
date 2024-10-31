extends AnimatableBody2D

@export_range(0.0, 10.0, 0.5, "suffix:secs") var reactivate_time: float = 3.0
@export_range(0.0, 10.0, 0.1, "suffix:secs") var throw_delay: float = 0.1
@export var throw_strength: Vector2 = Vector2(1000, 50)

@onready var animator = $AnimationPlayer
@onready var area = $Area2D

var player: CharacterBody2D

func _ready():
	area.body_entered.connect(throw)

func throw(body: CharacterBody2D) -> void:
	player = body
	area.set_collision_mask_value(2, false)
	await get_tree().create_timer(throw_delay).timeout
	animator.play("throw")
	var timer := get_tree().create_timer(reactivate_time)
	timer.timeout.connect(func(): area.set_collision_mask_value(2, true))

func add_impulse() -> void:
	var force_vector := Vector2(1, -1) * throw_strength
	EventBus.add_impulse.emit(force_vector)
