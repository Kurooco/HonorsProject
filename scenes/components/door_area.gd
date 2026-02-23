extends InteractionArea

@export var level_path : String
@export var spawn_point_name : String


func _on_activated() -> void:
	Autoload.set_player_disabled(true)
	if(spawn_point_name == ""):
		Autoload.level_handler.set_level(level_path, true)
	else:
		Autoload.level_handler.set_level_with_spawn_point(level_path, spawn_point_name)
