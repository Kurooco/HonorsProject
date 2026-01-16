extends CanvasLayer
class_name GeneralMenu

@export var hide_prev = true
var prev : Node

func _ready():
	Autoload.set_player_disabled(true)

func close():
	if(!is_instance_valid(prev)):
		Autoload.set_player_disabled(false)
	queue_free()
