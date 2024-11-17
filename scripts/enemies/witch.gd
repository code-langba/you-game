extends CharacterBody2D

@export var witch: WitchResource  

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
	movement_comp.apply_gravity(self, delta, witch.gravity)
	move_and_slide()

func attack(_body: CharacterBody2D) -> void:
	$witch_sfx.play()
	$anim.play("atk")
	# attack_delay_timer.start(witch.attack_delay)
	
func stop_attack(_body: CharacterBody2D) -> void:
	# if is_attacking:
	# 	await attack_delay_timer.timeout
	# 	attack_delay_timer.stop()
	$anim.play("idle")
	# attack_delay_timer.stop()
	# is_attacking = false

func throw_projectile() -> void:
	var projectile: RigidBody2D = projectileScene.instantiate()
	add_child(projectile)
	projectile.global_position = throw_pos.global_position
	projectile.apply_impulse(Vector2(witch.throw_direction, -witch.throw_trajectory_y) * witch.throw_force)
