extends CharacterBody2D


@export var gravity := 300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
@onready var sensor: Area2D = $sensor

var is_triggered := false

func _ready() -> void:
	visible = false
	sensor.body_entered.connect(in_area)

func in_area(_body) -> void:
	is_triggered = true
	visible = true
	$fall_sfx.play()
	sensor.queue_free()

func _physics_process(delta: float) -> void:
# 	# Add the gravity.
	if is_triggered:
		velocity.y += gravity * delta
#
# 	# Handle jump.
# 	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
# 		velocity.y = JUMP_VELOCITY
#
# 	# Get the input direction and handle the movement/deceleration.
# 	# As good practice, you should replace UI actions with custom gameplay actions.
# 	var direction := Input.get_axis("ui_left", "ui_right")
# 	if direction:
# 		velocity.x = direction * SPEED
# 	else:
# 		velocity.x = move_toward(velocity.x, 0, SPEED)
#
	move_and_slide()
