extends Button

@export var menu : GeneralMenu
@export var location : PackedScene
@export var fade : bool

func _on_pressed():
	if(fade):
		Autoload.level_handler.fade_out()
		await Autoload.level_handler.fade_ended
	if(is_instance_valid(location)):
		var new_menu = location.instantiate()
		new_menu.prev = menu
		get_tree().current_scene.add_child(new_menu)
	else:
		if(is_instance_valid(menu.prev)):
			menu.prev.show()
		menu.close()
	if(fade):
			Autoload.level_handler.fade_in()
