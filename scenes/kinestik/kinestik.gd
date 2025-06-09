extends Control

@onready var home_btn: TextureButton = $home_btn
@onready var video_layout: TextureRect = $video_layout
@onready var stop_btn: TextureButton = $video_layout/stop_btn
@onready var pause_btn: TextureButton = $video_layout/pause_btn
@onready var play_btn: TextureButton = $video_layout/play_btn
@onready var video_description: Label = $video_layout/video_description
@onready var video_title: Label = $video_layout/video_title
@onready var video_source: VideoStreamPlayer = $video_layout/video_source
@onready var video_border: TextureRect = $video_layout/video_border
@onready var video_thumbnail: TextureRect = $video_layout/video_thumbnail

var is_video_playing: bool = false
var video_playback_position: float = 0.0
var video_total_time: float = 0.0
var is_paused: bool = false

func _ready() -> void:
	Global.play_initial_animation($home_btn, 0.5, "TOP", 180.0, 0.3)
	Global.play_initial_animation($video_layout, 0.65, "BOTTOM", 1000.0, 0.3)
	video_source.finished.connect(_on_video_finished)
	reset_to_initial_state()

func reset_to_initial_state() -> void:
	is_video_playing = false
	is_paused = false
	video_playback_position = 0.0
	video_total_time = 0.0
	video_source.stop()
	video_description.text = "Ketuk play untuk memutar"
	disabled_enable_control_btn(play_btn, "ENABLED")
	disabled_enable_control_btn(pause_btn, "DISABLED")
	disabled_enable_control_btn(stop_btn, "DISABLED")

func format_time(seconds: float) -> String:
	var mins = int(seconds) / 60
	var secs = int(seconds) % 60
	return "%02d:%02d" % [mins, secs]

func _process(delta: float) -> void:
	if is_video_playing:
		video_playback_position = video_source.stream_position
		video_total_time = 220.0
		video_description.text = "%s / %s" % [
			format_time(video_playback_position),
			format_time(video_total_time)
		]
	elif is_paused:
		video_description.text = "%s / %s" % [
			format_time(video_playback_position),
			format_time(video_total_time)
		]

func _on_video_finished() -> void:
	is_video_playing = false
	is_paused = false
	print("video finished")
	reset_to_initial_state()

func _on_home_btn_pressed() -> void:
	Global.play_click_sound()
	Global.click_animation(home_btn)
	await get_tree().create_timer(0.3).timeout
	await get_tree().process_frame
	get_tree().change_scene_to_file("res://scenes/home/home.tscn")

func _on_play_btn_pressed() -> void:
	Global.play_click_sound()
	Global.click_animation(play_btn)
	
	Global.handle_activate_disabled_bgm("DISABLED")

	if is_paused:
		video_source.paused = false
	else:
		video_source.play()  # Memulai dari awal

	is_video_playing = true
	is_paused = false

	disabled_enable_control_btn(play_btn, "DISABLED")
	disabled_enable_control_btn(pause_btn, "ENABLED")
	disabled_enable_control_btn(stop_btn, "ENABLED")
	video_thumbnail.hide()

func _on_pause_btn_pressed() -> void:
	Global.play_click_sound()
	Global.click_animation(pause_btn)
	

	video_playback_position = video_source.stream_position
	video_source.paused = true
	
	if !Global.is_bgm_active : 
		Global.handle_activate_disabled_bgm()

	is_video_playing = false
	is_paused = true

	disabled_enable_control_btn(pause_btn, "DISABLED")
	disabled_enable_control_btn(play_btn, "ENABLED")
	disabled_enable_control_btn(stop_btn, "ENABLED")

func _on_stop_btn_pressed() -> void:
	Global.play_click_sound()
	Global.click_animation(stop_btn)
	
	if !Global.is_bgm_active : 
		Global.handle_activate_disabled_bgm()

	video_source.stop()
	video_source.stream_position = 0
	video_source.paused = false  # Reset pause juga

	is_video_playing = false
	is_paused = false
	video_thumbnail.show()

	reset_to_initial_state()

func disabled_enable_control_btn(_nodeElement: TextureButton, action: String) -> void:
	if action == "DISABLED":
		_nodeElement.disabled = true
		_nodeElement.modulate = Color(1, 1, 1, 0.3)
	else:
		_nodeElement.disabled = false
		_nodeElement.modulate = Color(1, 1, 1, 1)
