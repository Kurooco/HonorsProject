extends "res://scenes/components/interaction_area.gd"

@export var timeline : String
var in_conversation = false

func _ready():
	Dialogic.timeline_ended.connect($CooldownTimer.start)

func _on_activated():
	if(Dialogic.current_timeline == null && !in_conversation):
		in_conversation = true
		Dialogic.start(timeline)
		var camera = get_tree().get_first_node_in_group("level_camera")
		camera.focus(global_position)
		Dialogic.timeline_ended.connect(camera.defocus)

func _on_cooldown_timer_timeout():
	in_conversation = false
	activated_since_entering = false


func _on_exited():
	$CooldownTimer.stop()
	in_conversation = false
