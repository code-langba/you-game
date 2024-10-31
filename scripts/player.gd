class_name Player
extends CharacterBody2D


# Get the gravity from the project settings to be synced with RigidBody nodes.
@export var default_gravity := 980
@export var fall_gravity := 3000
@export var speed := 300.0
@export var jump_velocity := 800.0
@export var game_over_scene: PackedScene

@onready var player: AnimatedSprite2D = $Knight
#@onready var killzone: Area2D = get_parent().get_node("killzone")
@onready var gravity = default_gravity
@onready var timer: Timer = $SceneResetTimer

var is_ascend = false
var is_dead := false
var force: Vector2

func _ready() -> void:
	is_dead = false
	timer.timeout.connect(reload)
	# killzone.play_die.connect(play_die_anim)
	if PlayerManager.current_checkpoint != Vector2.ZERO:
		position = PlayerManager.current_checkpoint

	EventBus.player_died.connect(on_dead)
	EventBus.add_impulse.connect(add_impulse)
	EventBus.ascend.connect(func(): is_ascend = true)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if is_ascend:
		print('ascending')
		velocity = Vector2.UP * delta * 8000
		var tween = create_tween()
		tween.tween_property(self, "position:x", 3400, 2)
		player.play("ascending")
		move_and_slide()
		return
	if not is_on_floor():
		if velocity.y < 0:
			velocity.y += gravity * delta
		else:
			velocity.y += fall_gravity * delta

	var direction = 0

	if not is_dead:
		direction = Input.get_axis("move_left", "move_right")
	velocity.x = direction * speed

	handle_flip(direction)
	if not is_dead:
		handle_animation(direction)
		handle_jump()
	if not force == Vector2.ZERO:
		velocity += force
	if is_on_wall() or is_on_floor():
		force = Vector2.ZERO
	move_and_slide()


func handle_jump():
	if Input.is_action_just_pressed("jump") and is_on_floor() and not is_dead:
		velocity.y = -jump_velocity

func handle_flip(direction: float):
	if direction:
		player.flip_h = direction < 0
		
func handle_animation(direction: float):
	if direction and is_on_floor():
		player.play("run")
	elif not direction and is_on_floor():
		player.play("idle")
	elif not is_on_floor():
		player.play("jump")
	

func play_die_anim():
	player.play("die")
	await player.animation_finished
	await get_tree().create_timer(0.5).timeout
	is_dead = false
	call_deferred("load_game_over")
	

func on_dead() -> void:
	is_dead = true
	player.play("die")
	PlayerManager.lives -= 1
	if PlayerManager.lives < 1:
		# var anim = body
		play_die_anim()
		PlayerManager.reset()
		return
	timer.start()
	# call_deferred("reload")

func reload():
	# await get_tree().create_timer(0.5).timeout
	get_tree().reload_current_scene()

func load_game_over() -> void:
	get_tree().change_scene_to_packed(game_over_scene)

func add_impulse(force_vector: Vector2) -> void:
	force = force_vector
