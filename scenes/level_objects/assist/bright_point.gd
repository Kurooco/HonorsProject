extends "res://scenes/level_objects/assist/food_base.gd"

var t : Tween
var origin_position : Vector2
var notes = [1, 1.5, 2, 3, 4]

func _ready():
	origin_position = global_position

func _process(delta: float) -> void:
	global_position = origin_position + Vector2(sin(origin_position.x + Time.get_ticks_msec()/1000.0), cos(origin_position.y + Time.get_ticks_msec()/600.0))*20
	

func disappear():
	$Sound.pitch_scale = notes.pick_random()
	if(is_instance_valid(t)):
		t.kill()
	t = create_tween()
	$CPUParticles2D.emitting = true
	t.tween_property($Sprite2D, "self_modulate", Color(1, 0, 1, .5), .2)
	await get_tree().create_timer(3).timeout
	set_undetectable(false)
	t = create_tween()
	t.tween_property($Sprite2D, "self_modulate", Color(1, 1, 1, 1), 1)
