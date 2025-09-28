extends "res://scenes/components/interaction_area.gd"


func _on_activated():
	claim()
	
func claim():
	if(Autoload.level_handler.check_point != position):
		Autoload.level_handler.check_point = position
		Autoload.level_points = Autoload.run_points
	$AnimatedSprite2D.frame = 1
