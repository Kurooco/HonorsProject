extends "res://scenes/levels/rest_1.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	if(!PlayerStats.nighttime):
		$Window.frame = 1
		$Vivian.queue_free()
		$BedArea.queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_bed_area_activated() -> void:
	Autoload.set_player_disabled(true)
	Autoload.level_handler.set_level("res://scenes/levels/dorm/dream_1.tscn", true)
