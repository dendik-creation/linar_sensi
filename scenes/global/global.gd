extends Node

# BGM
var is_bgm_active : bool = true
const ACTIVE_MUSIC_TEXTURE = preload("res://assets/components/buttons/Volume Musik Penuh.png")
const MUTED_MUSIC_TEXTURE = preload("res://assets/components/buttons/Volume Musik Kosong.png")
@onready var main_backsound: AudioStreamPlayer = $main_backsound
func play_bgm() -> void :
	main_backsound.play()
func handle_activate_disabled_bgm(action = null) -> bool : 
	if action == "DISABLED" :
		is_bgm_active = false
		main_backsound.set_volume_db(-100)
		return false
	elif is_bgm_active :
		is_bgm_active = false
		main_backsound.set_volume_db(-100)
		return false
	else :
		is_bgm_active = true
		main_backsound.set_volume_db(0)
		return true
	
#	Btn Effect
@onready var click_sound: AudioStreamPlayer = $click_sound
var on_animate_click = false
func play_click_sound() -> void :
	click_sound.play()
func click_animation(_nodeElement: TextureButton, scale_factor := 0.9) -> void:
	if on_animate_click:
		return
	on_animate_click = true
	_nodeElement.pivot_offset = _nodeElement.size / 2.0
	var tween = get_tree().create_tween()
	var original_scale: Vector2 = _nodeElement.scale
	tween.tween_property(_nodeElement, "scale", original_scale * scale_factor, 0.1).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(_nodeElement, "scale", original_scale, 0.1).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	tween.tween_callback(Callable(self, "_on_click_animation_done"))
func _on_click_animation_done():
	on_animate_click = false
	
#	Node initial animation
func play_initial_animation(
	node: Node,
	delay: float,
	direction: String,
	offset: float,
	duration: float = 1.0
) -> void:
	if not node:
		push_error("Node tidak valid!")
		return

	# Simpan posisi asli
	var original_position = node.position

	# Hitung posisi awal berdasarkan direction + offset
	var start_position = original_position
	match direction.to_upper():
		"TOP":
			start_position.y -= offset
		"BOTTOM":
			start_position.y += offset
		"LEFT":
			start_position.x -= offset
		"RIGHT":
			start_position.x += offset
		_:
			push_error("Direction tidak valid: Gunakan TOP, BOTTOM, LEFT, RIGHT")
			return

	# Pindahkan langsung ke posisi awal (tanpa animasi)
	node.position = start_position

	# Buat tween untuk animasi
	var tween := create_tween()
	tween.set_pause_mode(1)

	tween.tween_interval(delay)
	tween.tween_property(
		node,
		"position",
		original_position,
		duration
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
