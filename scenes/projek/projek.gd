extends Control
@onready var home_btn: TextureButton = $home_btn
@onready var literasi_btn: TextureButton = $literasi_btn
@onready var narasi_btn: TextureButton = $narasi_btn
@onready var presentasi_btn: TextureButton = $presentasi_btn

func _ready() -> void:
	Global.play_initial_animation($home_btn, 0.5, "TOP", 180.0, 0.3)
	Global.play_initial_animation($literasi_btn, 0.75, "LEFT", 800, 0.5)
	Global.play_initial_animation($narasi_btn, 0.85, "LEFT", 800, 0.5)
	Global.play_initial_animation($presentasi_btn, 0.95, "LEFT", 800, 0.5)

func _on_home_btn_pressed() -> void:
	Global.play_click_sound()
	Global.click_animation(home_btn)
	await get_tree().create_timer(0.3).timeout
	await get_tree().process_frame
	get_tree().change_scene_to_file("res://scenes/home/home.tscn")

func _on_literasi_btn_pressed() -> void:
	Global.play_click_sound()
	Global.click_animation(literasi_btn)
	await get_tree().create_timer(0.3).timeout
	OS.shell_open("https://drive.google.com/your-literasi-link")

func _on_narasi_btn_pressed() -> void:
	Global.play_click_sound()
	Global.click_animation(narasi_btn)
	await get_tree().create_timer(0.3).timeout
	OS.shell_open("https://drive.google.com/your-literasi-link")
	
func _on_presentasi_btn_pressed() -> void:
	Global.play_click_sound()
	Global.click_animation(presentasi_btn)
	await get_tree().create_timer(0.3).timeout
	OS.shell_open("https://drive.google.com/your-literasi-link")
