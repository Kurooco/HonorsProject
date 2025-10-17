@tool
extends Node2D

@export var scene : PackedScene
@export var velocity : Vector2: 
	set(new_vel): 
		velocity = new_vel
		create_curve()
@export var delay = 1.0
@export var show_path = true

func _ready():
	$Timer.wait_time = delay
	if(show_path):
		create_curve()
	else:
		$Line2D.clear_points()
	

func get_arc_mover(node: Node):
	for child in node.get_children(true):
		if(child is ArcMover):
			return child
	return null

func _on_timer_timeout():
	if(abs(get_viewport().get_camera_2d().position.x - position.x) < get_viewport_rect().size.x):
		var new_scene = scene.instantiate()
		var arc_mover = get_arc_mover(new_scene)
		new_scene.global_position = global_position
		arc_mover.velocity = velocity
		Autoload.level_handler.current_level.add_child(new_scene)

func create_curve():
	$Line2D.clear_points()
	var v = velocity
	var gravity = 500
	var pos = Vector2.ZERO
	for i in range(200):
		$Line2D.add_point(pos)
		v.y += gravity*.01
		pos += v*.01
