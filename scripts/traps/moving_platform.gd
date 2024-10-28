extends CharacterBody2D

@export var is_fake := false
@export var loop: bool = true
@export var destroy_on_end: bool = false
@export var delay_on_start: float
@export var delay_on_end: float
@export_range(0, 5, 0.1, "or_greater", "suffix:secs") var destroy_delay: float
@export var SPEED := 300.0
@export var positions: Array[Position]
@export var animator: AnimatedSprite2D
@export var destroy_animation_name: String = ""

@onready var current_index := 0

func _ready() -> void:
	if is_fake:
		set_collision_layer_value(1, false)
	
	assert(positions, "❌Positions is empty. Create some position node inside BetterMovingPlatform and assign them to BetterMVBase.")

func _physics_process(_delta: float) -> void:
	var direction = (positions[current_index].global_position - global_position).normalized()
	velocity = SPEED * direction
	move_and_slide()
	
	flip_platform()
	handle_next_position(positions, direction)
	
func stop_processes(state: bool = true) -> void:
	set_physics_process(!state)
	set_process(!state)

func destroy() -> void:
	if destroy_delay == 0.0: 
		destroy_platform()
		return
		
	var destroy_timer = Timer.new()
	destroy_timer.autostart = true
	destroy_timer.one_shot = true
	destroy_timer.wait_time = destroy_delay
	destroy_timer.timeout.connect(destroy_platform)
	add_child(destroy_timer)
	
func destroy_platform() -> void:
	if !animator: 
		queue_free()
		return
	
	if destroy_animation_name: 
		animator.play(destroy_animation_name)
		await animator.animation_finished
	queue_free()

func flip_platform() -> void:
	if (!animator): return
	if sign(velocity.x) == -1:
		animator.flip_h = true
	elif sign(velocity.x) == 1:
		animator.flip_h = false

func handle_next_position(_positions: Array, direction: Vector2) -> void:
	if (positions[current_index].global_position - global_position).dot(direction) < 0:
		var prev_index = current_index
		if current_index == positions.size() - 1 and !loop: 
			if destroy_on_end: destroy()
			stop_processes()
		current_index = (current_index + 1) % positions.size()
		if current_index == prev_index: 
			if destroy_on_end: destroy()
			stop_processes()
