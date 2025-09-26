extends Path2D

@export var spawn_time = 100.0
@export var y_range = Vector2(-300, -100)
@export var x_range = Vector2(-30, 30)

var start_x = 0
var end_x = 5
var distance = 0
var start_point = 0
var end_point = 0

func _ready():
	start_point = curve.get_baked_points()[0].x+position.x
	end_point = curve.get_baked_points()[-1].x+position.x
	distance = end_point-start_point
	$Timer.wait_time = spawn_time / distance
	print($Timer.wait_time)

func _on_timer_timeout():
	#$Point1.global_position.x = start_x
	#$Point2.global_position.x = end_x
	start_point = curve.get_baked_points()[0].x+position.x
	end_point = curve.get_baked_points()[-1].x+position.x
	distance = end_point-start_point
	start_x = max(start_point, get_viewport().get_camera_2d().position.x-get_viewport().size.x/2)
	end_x = min(end_point, get_viewport().get_camera_2d().position.x+get_viewport().size.x/2)
	#var adjusted_distance_ratio = (end_x-start_x)/distance
	if(start_x >= end_x):
		return;
	
	
	$PathFollow2D.progress_ratio = randf()
	if($PathFollow2D.global_position.x > start_point && $PathFollow2D.global_position.x < end_point):
		var new_food = load("res://scenes/level_objects/assist/food.tscn").instantiate()
		new_food.global_position = $PathFollow2D.global_position
		new_food.velocity.y = randf_range(y_range.x, y_range.y)
		new_food.velocity.x = randf_range(x_range.x, x_range.y)
		get_tree().current_scene.add_child(new_food)
	
	
