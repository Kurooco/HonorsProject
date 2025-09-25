extends Node

var current_level = null
@export var opening_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	set_level(opening_scene.resource_path)

func _process(delta):
	$HUD/ProgressBar.value = (Autoload.player.health_component.health/float(Autoload.player.health_component.max_health))*100

func set_level(path: String):
	if(is_instance_valid(current_level)):
		remove_child(current_level)
		current_level.queue_free()
	var new_level = load(path).instantiate()
	add_child(new_level)
