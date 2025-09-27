extends Node

var current_level = null
@export var opening_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	Autoload.level_handler = self
	set_level(opening_scene.resource_path)



func set_level(path: String):
	if(is_instance_valid(current_level)):
		remove_child(current_level)
		current_level.queue_free()
	var new_level = load(path).instantiate()
	current_level = new_level
	add_child(new_level)
