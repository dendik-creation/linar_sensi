extends Control

@onready var home_btn: TextureButton = $home_btn
@onready var podcast_audio: AudioStreamPlayer = $podcast_audio
@onready var podcast_layout: TextureRect = $podcast_layout
@onready var disc_center: TextureRect = $podcast_layout/disc_center
@onready var podcast_title: Label = $podcast_layout/podcast_title
@onready var podcast_description: Label = $podcast_layout/podcast_description
@onready var stop_btn: TextureButton = $podcast_layout/stop_btn
@onready var pause_btn: TextureButton = $podcast_layout/pause_btn
@onready var play_btn: TextureButton = $podcast_layout/play_btn

var is_podcast_playing: bool = false
var podcast_playback_position: float = 0.0
var podcast_total_time: float = 0.0
var is_paused: bool = false

var disc_rotation_speed := 90.0

func _ready() -> void:
	Global.play_initial_animation($home_btn, 0.5, "TOP", 180.0, 0.3)
	Global.play_initial_animation($podcast_layout, 0.65, "BOTTOM", 1000.0, 0.3)
	podcast_audio.finished.connect(_on_podcast_finished)
	reset_to_initial_state()
	
func _on_podcast_finished() -> void:
	if is_podcast_playing:
		is_podcast_playing = false
		is_paused = false
		reset_to_initial_state()
		Global.handle_activate_disabled_bgm()


func reset_to_initial_state() -> void:
	disc_center.pivot_offset = disc_center.size / 2.0
	is_podcast_playing = false
	is_paused = false
	podcast_playback_position = 0.0
	podcast_description.text = "Ketuk play untuk memutar"
	disabled_enable_control_btn(play_btn, "ENABLED")
	disabled_enable_control_btn(pause_btn, "DISABLED")
	disabled_enable_control_btn(stop_btn, "DISABLED")
	disc_center.modulate = Color(1, 1, 1, 0.3)
	disc_center.rotation_degrees = 0.0



func format_time(seconds: float) -> String:
	var mins = int(seconds) / 60
	var secs = int(seconds) % 60
	return "%02d:%02d" % [mins, secs]


func _process(delta: float) -> void:
	if is_podcast_playing:
		var current_position = podcast_audio.get_playback_position()
		podcast_playback_position = current_position
		podcast_total_time = podcast_audio.stream.get_length()
		print(podcast_total_time)
		podcast_description.text = "%s / %s" % [
			format_time(current_position),
			format_time(podcast_total_time)
		]

		# Animasi disc berputar dan visible
		disc_center.rotation_degrees += disc_rotation_speed * delta
		disc_center.modulate = Color(1, 1, 1, 1.0)

	elif is_paused:
		podcast_description.text = "%s / %s" % [
			format_time(podcast_playback_position),
			format_time(podcast_total_time)
		]

		# Hentikan rotasi dan set opasitas redup
		disc_center.modulate = Color(1, 1, 1, 0.3)



func _on_home_btn_pressed() -> void:
	Global.play_click_sound()
	Global.click_animation(home_btn)
	if !Global.is_bgm_active : 
		Global.handle_activate_disabled_bgm()
	await get_tree().create_timer(0.3).timeout
	await get_tree().process_frame
	get_tree().change_scene_to_file("res://scenes/home/home.tscn")


func _on_play_btn_pressed() -> void:
	Global.play_click_sound()
	Global.click_animation(play_btn)
	Global.handle_activate_disabled_bgm()

	# Resume dari posisi terakhir
	podcast_audio.play(podcast_playback_position)
	is_podcast_playing = true
	is_paused = false
	
	Global.handle_activate_disabled_bgm("DISABLED")

	disabled_enable_control_btn(play_btn, "DISABLED")
	disabled_enable_control_btn(pause_btn, "ENABLED")
	disabled_enable_control_btn(stop_btn, "ENABLED")


func _on_pause_btn_pressed() -> void:
	Global.play_click_sound()
	Global.handle_activate_disabled_bgm()
	Global.click_animation(pause_btn)

	podcast_playback_position = podcast_audio.get_playback_position()
	podcast_audio.stop()
	is_podcast_playing = false
	is_paused = true

	disabled_enable_control_btn(pause_btn, "DISABLED")
	disabled_enable_control_btn(play_btn, "ENABLED")
	disabled_enable_control_btn(stop_btn, "ENABLED")


func _on_stop_btn_pressed() -> void:
	Global.play_click_sound()
	Global.handle_activate_disabled_bgm()
	Global.click_animation(stop_btn)
	
	if !Global.is_bgm_active : 
		Global.handle_activate_disabled_bgm()

	podcast_audio.stop()
	is_podcast_playing = false
	is_paused = false
	reset_to_initial_state()


func disabled_enable_control_btn(_nodeElement: TextureButton, action: String) -> void:
	if action == "DISABLED":
		_nodeElement.disabled = true
		_nodeElement.modulate = Color(1, 1, 1, 0.3)
	else:
		_nodeElement.disabled = false
		_nodeElement.modulate = Color(1, 1, 1, 1)
