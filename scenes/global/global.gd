extends Node
@onready var main_backsound: AudioStreamPlayer = $main_backsound

func play_bgm() -> void :
	main_backsound.play()
