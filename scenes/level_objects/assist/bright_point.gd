extends "res://scenes/level_objects/assist/food_base.gd"

func disappear():
	var t : Tween = create_tween()
	$CPUParticles2D.emitting = true
	t.tween_property(self, "modulate", Color(1, 0, 1, .5), .2)
	await get_tree().create_timer(3).timeout
	set_undetectable(false)
	t = create_tween()
	t.tween_property(self, "modulate", Color(1, 1, 1, 1), 1)
