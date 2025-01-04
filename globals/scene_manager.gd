extends CanvasLayer

@onready var mat: Material
var tween: Tween

func _ready() -> void:
	mat = $ColorRect.material

func change_scene_to_file(scene: String, transition_duration: float = 1) -> void:
	await play_scene_transition_close(transition_duration)
	get_tree().change_scene_to_file(scene)
	await play_scene_transition_open(transition_duration)
	
func change_scene_to_packed(scene: PackedScene, transition_duration: float = 1) -> void:
	await play_scene_transition_close(transition_duration)
	get_tree().change_scene_to_packed(scene)
	await play_scene_transition_open(transition_duration)
	
func play_scene_transition_close(transition_duration: float = 1) -> Signal:
	set_param(-0.3)
	tween = create_tween()
	tween.tween_property(mat, "shader_parameter/dissolve_value", 1.3, transition_duration)
	return tween.finished
	
func play_scene_transition_open(transition_duration: float = 1) -> Signal:
	set_param(1.3)
	tween = create_tween()
	tween.tween_property(mat, "shader_parameter/dissolve_value", -0.3, transition_duration)
	return tween.finished

func set_param(value: float) -> void:
	if mat: mat.set_shader_parameter("dissolve_value", value)
