extends Control

@onready var h_slider_music: HSlider = %HSliderMusic
@onready var h_slider_sfx: HSlider = %HSliderSFX
@onready var master_bus_idx = AudioServer.get_bus_index("Master")
@onready var music_bus_idx = AudioServer.get_bus_index("Music")
@onready var sfx_bus_idx = AudioServer.get_bus_index("Sfx")
@onready var back_btn: Button = %BackBtn
@onready var h_slider_main: HSlider = %HSliderMain
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	back_btn.grab_focus()
	back_btn.pressed.connect(func(): close_setting())
	h_slider_music.value_changed.connect(on_value_changed.bind("music"))
	h_slider_sfx.value_changed.connect(on_value_changed.bind("sfx"))
	h_slider_main.value_changed.connect(on_value_changed.bind("master"))
	h_slider_music.value =  -6.0 if AudioServer.is_bus_mute(music_bus_idx) else AudioServer.get_bus_volume_db(music_bus_idx)
	h_slider_sfx.value = -6.0 if AudioServer.is_bus_mute(sfx_bus_idx) else AudioServer.get_bus_volume_db(sfx_bus_idx)
	h_slider_main.value = -6.0 if AudioServer.is_bus_mute(master_bus_idx) else AudioServer.get_bus_volume_db(master_bus_idx)

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_GO_BACK_REQUEST or what == NOTIFICATION_WM_CLOSE_REQUEST:
		close_setting()

func close_setting() -> void:
	EventBus.setting_close.emit()
	queue_free()

func on_value_changed(value: float, invoker: String) -> void:
	match invoker:
		"music":
			change_bus_volume(music_bus_idx, value)
		"sfx":
			change_bus_volume(sfx_bus_idx, value)
		"master":
			change_bus_volume(master_bus_idx, value)
			

func change_bus_volume(bus_id: int, value: float) -> void:
	if value == -6:
		AudioServer.set_bus_mute(bus_id, true)
		return
		
	AudioServer.set_bus_mute(bus_id, false)
	AudioServer.set_bus_volume_db(bus_id, value)
	audio_stream_player.play()
