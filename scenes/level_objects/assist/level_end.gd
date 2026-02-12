extends InteractionArea

@export var next_level : String

func _on_activated():
	PlayerStats.sync_points()
	Autoload.level_handler.end_level(next_level)
	MusicHandler.play(load("res://sound/sfx/game sounds/welldone.wav"))
