extends Control

func _ready() -> void:
	Global.play_bgm()

func _on_any_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/home/home.tscn")
