extends CanvasLayer

@onready var location_container = $LocationContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	for location in location_container.get_children():
		location.selected.connect(hide)


func _on_cancel_pressed():
	hide()


func _on_visibility_changed():
	Autoload.set_player_disabled(visible)
