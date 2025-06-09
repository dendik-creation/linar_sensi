extends Control
@onready var klik_apapun: TextureRect = $klik_apapun

func _ready() -> void:
	Global.play_bgm()
	Global.play_initial_animation($klik_apapun, 0.5, "BOTTOM", 180.0, 0.3)

func _on_any_btn_pressed() -> void:
	Global.play_click_sound()
	get_tree().change_scene_to_file("res://scenes/home/home.tscn")
