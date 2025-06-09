extends Control
@onready var music_btn: TextureButton = $music_btn
@onready var dev_btn: TextureButton = $dev_btn
@onready var audio_btn: TextureButton = $audio_btn
@onready var visual_btn: TextureButton = $visual_btn
@onready var projek_btn: TextureButton = $projek_btn
@onready var kinestik_btn: TextureButton = $kinestik_btn
@onready var quit_btn: TextureButton = $quit_btn

func _ready() -> void:
	if Global.is_bgm_active :
		music_btn.texture_normal = Global.ACTIVE_MUSIC_TEXTURE
	else :
		music_btn.texture_normal = Global.MUTED_MUSIC_TEXTURE
	Global.play_initial_animation($music_btn, 0.5, "TOP", 180.0, 0.3)
	Global.play_initial_animation($dev_btn, 0.6, "TOP", 180.0, 0.3)
	Global.play_initial_animation($quit_btn, 0.7, "TOP", 180.0, 0.3)
	Global.play_initial_animation($audio_btn, 0.75, "LEFT", 700, 0.5)
	Global.play_initial_animation($visual_btn, 0.85, "LEFT", 700, 0.5)
	Global.play_initial_animation($kinestik_btn, 0.95, "LEFT", 700, 0.5)
	Global.play_initial_animation($projek_btn, 1.05, "LEFT", 700, 0.5)


func _on_music_btn_pressed() -> void:
	Global.click_animation(music_btn)
	Global.play_click_sound()
	if Global.handle_activate_disabled_bgm() : 
		music_btn.texture_normal = Global.ACTIVE_MUSIC_TEXTURE
	else :
		music_btn.texture_normal = Global.MUTED_MUSIC_TEXTURE
		
func _on_dev_btn_pressed() -> void:
	Global.click_animation(dev_btn)
	Global.play_click_sound()
	await get_tree().create_timer(0.3).timeout
	await get_tree().process_frame
	get_tree().change_scene_to_file("res://scenes/about/about.tscn")


func _on_audio_btn_pressed() -> void:
	Global.click_animation(audio_btn)
	Global.play_click_sound()
	await get_tree().create_timer(0.3).timeout
	await get_tree().process_frame
	get_tree().change_scene_to_file("res://scenes/audio/audio_podcast.tscn")


func _on_visual_btn_pressed() -> void:
	Global.click_animation(visual_btn)
	Global.play_click_sound()
	await get_tree().create_timer(0.3).timeout
	await get_tree().process_frame
	get_tree().change_scene_to_file("res://scenes/visual/visual.tscn")


func _on_projek_btn_pressed() -> void:
	Global.click_animation(projek_btn)
	Global.play_click_sound()
	await get_tree().create_timer(0.3).timeout
	await get_tree().process_frame
	get_tree().change_scene_to_file("res://scenes/projek/projek.tscn")


func _on_kinestik_btn_pressed() -> void:
	Global.click_animation(kinestik_btn)
	Global.play_click_sound()
	await get_tree().create_timer(0.3).timeout
	await get_tree().process_frame
	get_tree().change_scene_to_file("res://scenes/kinestik/kinestik.tscn")


func _on_quit_btn_pressed() -> void :
	Global.click_animation(quit_btn)
	Global.play_click_sound()
	await get_tree().create_timer(0.5).timeout
	get_tree().quit()
