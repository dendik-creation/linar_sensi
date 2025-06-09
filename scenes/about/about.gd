extends Control
@onready var home_btn: TextureButton = $home_btn
@onready var about_me: TextureRect = $about_me

func _ready() -> void:
	Global.play_initial_animation($home_btn, 0.5, "TOP", 180.0, 0.3)
	Global.play_initial_animation($about_me, 0.5, "BOTTOM", 1000.0, 0.5)

func _on_home_btn_pressed() -> void:
	Global.play_click_sound()
	Global.click_animation(home_btn)
	await get_tree().create_timer(0.3).timeout
	await get_tree().process_frame
	get_tree().change_scene_to_file("res://scenes/home/home.tscn")
	
