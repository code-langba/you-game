extends CharacterBody2D

@export var gravity := 300.0
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var sensor: Area2D = $sensor
var is_triggered := false

func _ready() -> void:
	sprite_2d.visible = false
	sensor.body_entered.connect(in_area)

func in_area(_body) -> void:
	is_triggered = true
	sprite_2d.visible = true
	$fall_sfx.play()
	sensor.queue_free()

func _physics_process(delta: float) -> void:
	if is_triggered:
		velocity.y += gravity * delta
	move_and_slide()
