extends InteractionArea

@export var level_path : String


func _on_activated() -> void:
	Autoload.level_handler.set_level(level_path, true)
