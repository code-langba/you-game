extends StaticBody2D

@onready var hitbox: Area2D = $Area2D

var triggered := false

@export var speed := 20.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hitbox.body_entered.connect(_on_body_entered)

func _on_body_entered(_body: Node2D) -> void:
	triggered = true
	await get_tree().create_timer(1.0).timeout
	queue_free()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if triggered:
		position += Vector2.DOWN * speed
		
