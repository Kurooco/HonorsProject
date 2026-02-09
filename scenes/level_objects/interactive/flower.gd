extends "res://scenes/components/interaction_area.gd"

var sway = 0.0
var sway_speed = 1.0
var sway_tween : Tween = null
var initial_rotation
var sway_amount = 0.0
@export var min_sway = 0.0
@export var min_sway_speed = 1.0
@export var max_sway_speed = 8.0

func _ready():
	initial_rotation = rotation
	sway_speed = min_sway_speed

func _on_entered():
	sway_tween = create_tween()
	sway_tween.tween_property(self, "sway", .8, .1)
	sway_tween.parallel().tween_property(self, "sway_speed", max_sway_speed, .1)
	sway_tween.tween_property(self, "sway", 0.0, 2).set_trans(Tween.TRANS_CUBIC)
	sway_tween.parallel().tween_property(self, "sway_speed", min_sway_speed, 4).set_trans(Tween.TRANS_CUBIC)

func _process(delta):
	sway_amount += delta*sway_speed
	rotation = sin((sway_amount) + position.x + initial_rotation*2)*(sway+min_sway) + initial_rotation
	#rotation = sin((Time.get_ticks_msec()/100.0) + position.x + initial_rotation)*(sway+min_sway) + initial_rotation
	#if(!is_instance_valid(sway_tween) || !sway_tween.is_running()):
	#	sway = max(0, sway-(delta/2.0))
