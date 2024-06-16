extends CharacterBody2D

@export var is_fake := false
@export var direction := 1.0
@export var SPEED = 300.0
@export var start: Node2D
@export var end: Node2D


@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	if is_fake:
		set_collision_layer_value(1, false)
	

func _physics_process(_delta: float) -> void:
	if global_position.x > end.global_position.x - 5 or global_position.x < start.global_position.x - 5:
		direction *= -1
		sprite.scale.x *= -1
	position.x += SPEED * direction * _delta

	
