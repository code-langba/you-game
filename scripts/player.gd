class_name Player

extends CharacterBody2D


# Get the gravity from the project settings to be synced with RigidBody nodes.
@export var default_gravity := 980
@export var fall_gravity := 3000
@export var speed := 300.0
@export var jump_velocity := 800.0

@onready var player:AnimatedSprite2D = $Knight
@onready var killzone: Area2D = get_parent().get_node("killzone")
@onready var gravity = default_gravity

var is_dead := false

func _ready() -> void:
	is_dead = false
	killzone.play_die.connect(play_die_anim)
	if PlayerManager.current_checkpoint != Vector2.ZERO:
		position = PlayerManager.current_checkpoint

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		if velocity.y < 0:
			velocity.y += gravity * delta
		else:
			velocity.y += fall_gravity * delta



	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")

	velocity.x = direction * speed

	handle_flip(direction)
	if is_dead:
		play_die_anim()
	else:
		handle_animation(direction)
	handle_jump()
	move_and_slide()


func handle_jump():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_velocity

func handle_flip(direction:float):
	if direction:
		player.flip_h = direction < 0
		
func handle_animation(direction:float):
	if direction and is_on_floor():
		player.play("run")
	elif not direction and is_on_floor():
		player.play("idle")
	elif not is_on_floor():
		player.play("jump")
	

func play_die_anim():
	player.play("die")



