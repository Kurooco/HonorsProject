extends CanvasLayer

var displayed_points = 0.0

var heart_progress = [
	preload("res://art/ui/counters/hearts3.png"),
	preload("res://art/ui/counters/hearts4.png"),
	preload("res://art/ui/counters/hearts5.png"),
	preload("res://art/ui/counters/hearts6.png"),
	preload("res://art/ui/counters/hearts7.png"),
]
var acorn_progress = [
	preload("res://art/ui/counters/acorns3.png"),
	preload("res://art/ui/counters/acorns4.png"),
	preload("res://art/ui/counters/acorns5.png"),
	preload("res://art/ui/counters/acorns6.png"),
	preload("res://art/ui/counters/acorns7.png"),
]

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_parent().data_loaded
	PlayerStats.stat_updated.connect(update_hud)
	update_hud()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(is_instance_valid(Autoload.player)):
		show()
		$Health.value = (Autoload.player.health_component.health/float(Autoload.player.health_component.max_health))*100
		displayed_points = lerp(displayed_points, float(PlayerStats.run_points), 1 - pow(.05, delta))
		$Points.text = "Points: "+str(int(round(displayed_points)))
		$AcornProgress.value = (Autoload.player.acorns/float(Autoload.player.max_acorns))*100
		if(Autoload.player.acorn_energy > 0):
			$AcornEnergy.show()
			$AcornEnergy.value = Autoload.player.acorn_energy
		else:
			$AcornEnergy.hide()
	else:
		hide()
	
func update_hud():
	$Health.texture_progress = heart_progress[PlayerStats.lives]
	$Health.texture_under = heart_progress[PlayerStats.lives]
	$AcornProgress.texture_progress = acorn_progress[PlayerStats.acorns]
	$AcornProgress.texture_under = acorn_progress[PlayerStats.acorns]
