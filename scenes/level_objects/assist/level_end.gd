extends InteractionArea

@export var next_level : String

func _on_activated():
	Autoload.level_handler.end_level(next_level)
