extends Path2D

@export var spawn_time = .5
@export var y_range = Vector2(-800, -500)
@export var x_range = Vector2(-300, 300)
@export var spawn_item = preload("res://scenes/level_objects/assist/food.tscn")
@export var disabled = false
@export var right_bias_threshold = 5
@export var alternate = true

var start_x = 0
var end_x = 0
var half_x = 0
var distance = 0
var start_point = 0
var end_point = 0
var adjusted_distance_ratio = 0
var left_spawned = 0
var on_right = false

var current_time = 0

func _ready():
	pass

func _process(delta):
	start_point = curve.get_baked_points()[0].x+position.x
	end_point = curve.get_baked_points()[-1].x+position.x
	distance = end_point-start_point
	start_x = max(start_point, get_viewport().get_camera_2d().position.x-get_viewport().size.x/2)
	half_x = min(end_point, get_viewport().get_camera_2d().position.x)
	end_x = min(end_point, get_viewport().get_camera_2d().position.x+get_viewport().size.x/2)
	adjusted_distance_ratio = (end_x-start_x)/get_viewport().size.x

	current_time += delta
	if(adjusted_distance_ratio <= 0 || disabled || current_time < spawn_time/adjusted_distance_ratio):
		return;
	
	current_time = 0
	$Point1.global_position.x = start_x
	$Point2.global_position.x = end_x
	
	if(alternate):
		if(on_right):
			start_x = half_x
		else:
			end_x = half_x
		on_right = !on_right
	else:
		if(start_x-half_x < 0):
			left_spawned += 1
			if(left_spawned > right_bias_threshold):
				start_x = half_x
				left_spawned = 0
		else:
			left_spawned = 0
	
	$PathFollow2D.progress_ratio = randf_range((start_x-start_point)/distance, ((end_x-start_point))/distance)
	var new_food = spawn_item.instantiate()
	var arc_mover = get_arc_mover(new_food)
	new_food.global_position = $PathFollow2D.global_position
	var relative_position_ratio = ($PathFollow2D.position.x - get_viewport().get_camera_2d().position.x)/get_viewport_rect().size.x
	arc_mover.velocity.y = randf_range(y_range.x, y_range.y)
	arc_mover.velocity.x = randf_range(0 if relative_position_ratio < -.3 else x_range.x, 0 if relative_position_ratio > .3 else x_range.y)
	get_tree().current_scene.add_child(new_food)
	
	
func get_arc_mover(node: Node):
	for child in node.get_children(true):
		if(child is ArcMover):
			return child
	return null
