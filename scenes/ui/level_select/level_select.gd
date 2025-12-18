extends CanvasLayer

@onready var location_container = $LocationContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	var ind = 0
	for location in location_container.get_children():
		if(ind >= PlayerStats.levels_unlocked):
			location.lock()
		else:
			location.selected.connect(hide)
		ind += 1


func _on_cancel_pressed():
	hide()


func _on_visibility_changed():
	Autoload.set_player_disabled(visible)
