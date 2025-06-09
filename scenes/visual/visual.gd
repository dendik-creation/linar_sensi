extends Control
@onready var home_btn: TextureButton = $home_btn
@onready var ppt_texture: TextureRect = $ppt_texture
const MATERI_1 = preload("res://assets/partials/images/scenes/visual/materi_1.png")
const MATERI_2 = preload("res://assets/partials/images/scenes/visual/materi_2.png")
const MATERI_3 = preload("res://assets/partials/images/scenes/visual/materi_3.png")
const MATERI_4 = preload("res://assets/partials/images/scenes/visual/materi_4.png")
const MATERI_5 = preload("res://assets/partials/images/scenes/visual/materi_5.png")
const MATERI_6 = preload("res://assets/partials/images/scenes/visual/materi_6.png")
const MATERI_7 = preload("res://assets/partials/images/scenes/visual/materi_7.png")
const materials = [MATERI_1, MATERI_2, MATERI_3, MATERI_4, MATERI_5, MATERI_6, MATERI_7]
var materi_index : int = 0;
@onready var back_btn: TextureButton = $back_btn
@onready var next_btn: TextureButton = $next_btn

func _ready() -> void:
	Global.play_initial_animation($home_btn, 0.5, "TOP", 180.0, 0.3)
	Global.play_initial_animation($ppt_texture, 0.8, "BOTTOM", 1000.0, 0.3)
	Global.play_initial_animation($back_btn, 0.8, "LEFT", 250.0, 0.3)
	Global.play_initial_animation($next_btn, 0.8, "RIGHT", 250.0, 0.3)
	
	materi_index = 0
	ppt_texture.texture = materials[materi_index]

func _on_home_btn_pressed() -> void :
	Global.play_click_sound()
	Global.click_animation(home_btn)
	await get_tree().create_timer(0.3).timeout
	await get_tree().process_frame
	get_tree().change_scene_to_file("res://scenes/home/home.tscn")

func handle_change_materi(action : String) -> void :
	if action == "BACK" :
		materi_index = materi_index - 1
	elif action == "NEXT" :
		materi_index = materi_index + 1
	ppt_texture.texture = materials[materi_index]

func _on_back_btn_pressed() -> void:
	Global.play_click_sound()
	Global.click_animation(back_btn)
	if materi_index > 0 :
		handle_change_materi("BACK")

func _on_next_btn_pressed() -> void:
	Global.play_click_sound()
	Global.click_animation(next_btn)
	if materi_index < materials.size() - 1 :
		handle_change_materi("NEXT")
