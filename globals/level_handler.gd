extends Node

@export var opening_scene : PackedScene
@onready var fade = $FadeCanvas/Fade
var current_level : Node = null
var fade_tween : Tween = null
var check_point = Vector2.ZERO

signal fade_ended

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


func restart_level():
	fade_out()
	await fade_ended
	await get_tree().create_timer(1).timeout
	if(is_instance_valid(current_level)):
		remove_child(current_level)
		current_level.queue_free()
	var new_level = load(current_level.scene_file_path).instantiate()
	current_level = new_level
	
	var player = get_node_in_group(current_level, "player")
	var camera = get_node_in_group(current_level, "level_camera")
	player.position = check_point
	camera.position.x = check_point.x
	for i in get_nodes_in_group(current_level, "checkpoint"):
		if(i.position == check_point):
			i.claim()
	Autoload.run_points = Autoload.level_points
	add_child(new_level)
	fade_in()

func fade_out(color=Color.BLACK):
	if(is_instance_valid(fade_tween)):
		fade_tween.kill()
	fade_tween = create_tween()
	fade_tween.tween_property(fade, "color", color, 1)
	fade_tween.tween_callback(fade_ended.emit)
	
func fade_in():
	var transparent_color = Color(fade.color.r, fade.color.g, fade.color.b, 0)
	if(is_instance_valid(fade_tween)):
		fade_tween.kill()
	fade_tween = create_tween()
	fade_tween.tween_property(fade, "color", transparent_color, 1)
	fade_tween.tween_callback(fade_ended.emit)

func get_node_in_group(node, group) -> Node:
	var children : Array = node.get_children().duplicate()
	for child in children:
		if(child.is_in_group(group)):
			return child
		var group_child = get_node_in_group(child, group)
		if(group_child != null):
			return group_child
	return null

func get_nodes_in_group(node, group) -> Array[Node]:
	var children : Array = node.get_children().duplicate()
	var group_children : Array[Node] = []
	for child in children:
		if(child.is_in_group(group)):
			group_children.append(child)
		group_children.append_array(get_nodes_in_group(child, group))
	return group_children
