extends CharacterBody2D

@export var speed: float = 200
@export var gravity: float = 2300

@onready var hitbox = $Hitbox
@onready var animation_player = $AnimationPlayer
@onready var killzone = $killzone
@onready var movement_comp: MovementComponent = $Movement

func _ready() -> void:
	hitbox.body_entered.connect(play_attack)
	disable_killzone()

func _physics_process(delta: float) -> void:
	movement_comp.apply_gravity(self, delta, gravity)
	movement_comp.walk(self, speed)
	move_and_slide()

func play_attack(_body: Node) -> void:
	movement_comp.pause_movement = true
	animation_player.play("attack")
	await animation_player.animation_finished
	movement_comp.pause_movement = false

func play_idle() -> void:
	animation_player.play("walk")
	
func enable_killzone() -> void:
	killzone.set_collision_mask_value(2, true)

func disable_killzone() -> void:
	killzone.set_collision_mask_value(2, false)
