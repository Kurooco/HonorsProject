extends Path2D

@export var spawn_time = 0.4
@export var y_range = Vector2(-300, -100)
@export var x_range = Vector2(-30, 30)
@export var spawn_item = preload("res://scenes/level_objects/assist/food.tscn")
@export var disabled = false

var start_x = 0
var end_x = 0
var distance = 0
var start_point = 0
var end_point = 0
var adjusted_distance_ratio = 0

func _ready():
	$Timer.wait_time = spawn_time

func _process(delta):
	start_point = curve.get_baked_points()[0].x+position.x
	end_point = curve.get_baked_points()[-1].x+position.x
	distance = end_point-start_point
	start_x = max(start_point, get_viewport().get_camera_2d().position.x-get_viewport().size.x/2)
	end_x = min(end_point, get_viewport().get_camera_2d().position.x+get_viewport().size.x/2)
	adjusted_distance_ratio = (end_x-start_x)/get_viewport().size.x
	$Timer.wait_time = spawn_time / adjusted_distance_ratio

func _on_timer_timeout():
	if(adjusted_distance_ratio <= 0 || disabled):
		return;
	
	$Point1.global_position.x = start_x
	$Point2.global_position.x = end_x
	
	$PathFollow2D.progress_ratio = randf_range((start_x-start_point)/distance, ((end_x-start_point))/distance)
	var new_food = spawn_item.instantiate()
	var arc_mover = get_arc_mover(new_food)
	new_food.global_position = $PathFollow2D.global_position
	arc_mover.velocity.y = randf_range(y_range.x, y_range.y)
	arc_mover.velocity.x = randf_range(x_range.x, x_range.y)
	get_tree().current_scene.add_child(new_food)
	
	
func get_arc_mover(node: Node):
	for child in node.get_children(true):
		if(child is ArcMover):
			return child
	return null
