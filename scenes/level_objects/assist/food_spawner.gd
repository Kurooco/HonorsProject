extends Path2D

@export var spawn_time = 0.1
@export var y_range = Vector2(-300, -100)
@export var x_range = Vector2(-30, 30)


func _ready():
	$Timer.wait_time = spawn_time


func _on_timer_timeout():
	$PathFollow2D.progress_ratio = randf()
	var new_food = load("res://scenes/level_objects/assist/food.tscn").instantiate()
	new_food.global_position = $PathFollow2D.global_position
	new_food.velocity.y = randf_range(y_range.x, y_range.y)
	new_food.velocity.x = randf_range(x_range.x, x_range.y)
	get_tree().current_scene.add_child(new_food)
