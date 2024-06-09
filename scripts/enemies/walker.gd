extends CharacterBody2D

@export var is_friendly := false
@export var direction := 1.0
@export var SPEED = 300.0

@onready var walking_component: WalkComponent = $walking

func _ready() -> void:
	if is_friendly:
		var killzone: Area2D = $killzone
		killzone.set_collision_mask_value(2, false)

func _physics_process(_delta: float) -> void:
	var values = walking_component.walk(velocity, direction, scale, SPEED)
	velocity = values[0]
	direction = values[1]
	scale = values[2]
	move_and_slide()
