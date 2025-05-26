extends Control
@onready var timer: Timer = $timer
@onready var load_splash: ProgressBar = $load_splash

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if load_splash.value > 40:
		load_splash.value += 0.3
	elif load_splash.value > 70 :
		load_splash.value += 0.4
	else : 
		load_splash.value += 0.1
	if load_splash.value == 100 :
		timer.start(2)
		get_tree().change_scene_to_file("res://scenes/home_screen.tscn")
		
