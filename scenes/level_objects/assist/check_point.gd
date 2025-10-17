extends "res://scenes/components/interaction_area.gd"

@export var set_as_claimed = false

func _ready():
	if(set_as_claimed):
		claim()

func _on_activated():
	claim()
	
func claim():
	if(Autoload.level_handler.check_point != position):
		Autoload.level_handler.claim_checkpoint(position)
		PlayerStats.level_points = PlayerStats.run_points
	$AnimatedSprite2D.frame = 1
