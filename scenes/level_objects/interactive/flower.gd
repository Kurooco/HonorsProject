extends "res://scenes/components/interaction_area.gd"

var sway = 0.0
var sway_tween : Tween = null

func _on_entered():
	sway_tween = create_tween()
	sway_tween.tween_property(self, "sway", 1.0, .1)
	sway_tween.tween_property(self, "sway", 0.0, 1)

func _process(delta):
	rotation = sin(Time.get_ticks_msec()/100.0)*sway
	#if(!is_instance_valid(sway_tween) || !sway_tween.is_running()):
	#	sway = max(0, sway-(delta/2.0))
