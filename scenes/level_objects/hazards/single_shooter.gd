extends Node2D

@export var scene : PackedScene
@export var velocity : Vector2


func get_arc_mover(node: Node):
	for child in node.get_children(true):
		if(child is ArcMover):
			return child
	return null

func _on_timer_timeout():
	var new_scene = scene.instantiate()
	var arc_mover = get_arc_mover(new_scene)
	new_scene.global_position = global_position
	arc_mover.velocity = velocity
	Autoload.level_handler.current_level.add_child(new_scene)
