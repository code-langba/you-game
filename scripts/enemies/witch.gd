extends CharacterBody2D

@export var gravity: float = 1000

@export_group("Attack")
@export_enum("LEFT:-1", "RIGHT:1") var throw_direction: int = -1
## This is the delay between attacks. The higher the slower.
@export_range(0, 5, 0.1, "or_greater", "suffix: secs") var attack_delay: float = 1
## Positive aims up while negative aims down.
@export_range(-1, 1, 0.1) var throw_trajectory_y: float = 0.2
@export var throw_force: float = 1000

@onready var projectileScene: PackedScene = preload("res://scenes/enemies/projectile1.tscn")
@onready var attack_delay_timer: Timer = $AttackDelayTimer
@onready var hitbox: Area2D = $Hitbox
@onready var throw_pos: Marker2D = $ThrowPos
@onready var movement_comp: MovementComponent = $Movement

var is_attacking: bool = false

func _ready() -> void:
	hitbox.body_entered.connect(attack)
	hitbox.body_exited.connect(stop_attack)
	attack_delay_timer.timeout.connect(throw_projectile)

func _physics_process(delta: float) -> void:
	movement_comp.apply_gravity(self, delta, gravity)
	move_and_slide()

func attack(_body: CharacterBody2D) -> void:
	attack_delay_timer.start(attack_delay)
	is_attacking = true
	
func stop_attack(_body: CharacterBody2D) -> void:
	if is_attacking:
		await attack_delay_timer.timeout
		attack_delay_timer.stop()
	attack_delay_timer.stop()
	is_attacking = false

func throw_projectile() -> void:
	var projectile: RigidBody2D = projectileScene.instantiate()
	add_child(projectile)
	projectile.global_position = throw_pos.global_position
	projectile.apply_impulse(Vector2(throw_direction, -throw_trajectory_y) * throw_force)
