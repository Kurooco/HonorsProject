extends InteractionArea


func _on_activated():
	if(Autoload.group == 1):
		Autoload.level_handler.end_level("res://scenes/levels/rest_1.tscn")
	else:
		Autoload.level_handler.end_level("res://scenes/levels/infinite_level.tscn")
	MusicHandler.play("res://sound/sfx/game sounds/welldone.wav")
