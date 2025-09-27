extends CanvasLayer

var displayed_points = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$ProgressBar.value = (Autoload.player.health_component.health/float(Autoload.player.health_component.max_health))*100
	displayed_points = lerp(displayed_points, float(Autoload.points), 1 - pow(.05, delta))
	$Points.text = "Points: "+str(int(round(displayed_points)))
