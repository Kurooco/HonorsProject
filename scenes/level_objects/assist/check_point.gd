extends "res://scenes/components/interaction_area.gd"

@export var set_as_claimed = false

var bird_killed = false

func _process(delta):
	if(!bird_killed):
		$Bird.skew = sin(Time.get_ticks_msec()/200.0)/5.0
	else:
		$Bird.position.y += delta*400
		$Bird.rotation += delta*10
	

func _ready():
	if(set_as_claimed):
		claim(false)

func _on_activated():
	claim(true)
	
func claim(effects:bool):
	if(Autoload.level_handler.check_point != position):
		Autoload.level_handler.claim_checkpoint(position)
		PlayerStats.level_points = PlayerStats.run_points
	if(effects):
		bird_killed = true
		$AudioStreamPlayer2D.play()
	else:
		$Bird.hide()
		disabled = true
