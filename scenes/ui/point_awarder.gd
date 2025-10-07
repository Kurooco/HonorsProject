extends Node2D


func award_points(amount: int) -> void:
	if(Autoload.in_rest_level):
		PlayerStats.add_points_permanent(amount)
	else:
		PlayerStats.run_points += amount 
	var new_label : Label = load("res://scenes/ui/point_label.tscn").instantiate()
	new_label.text = str(amount)
	new_label.global_position = global_position
	#get_tree().current_scene.add_child(new_label)
	Autoload.level_handler.current_level.add_child(new_label)
	
	
