extends CanvasLayer

var displayed_points = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(is_instance_valid(Autoload.player)):
		$ProgressBar.value = (Autoload.player.health_component.health/float(Autoload.player.health_component.max_health))*100
		displayed_points = lerp(displayed_points, float(PlayerStats.run_points), 1 - pow(.05, delta))
		$Points.text = "Points: "+str(int(round(displayed_points)))
		$AcornProgress.value = (Autoload.player.acorns/float(Autoload.player.max_acorns))*100
		if(Autoload.player.acorn_energy > 0):
			$AcornEnergy.show()
			$AcornEnergy.value = Autoload.player.acorn_energy
		else:
			$AcornEnergy.hide()
	else:
		$ProgressBar.value = 0
	
	
