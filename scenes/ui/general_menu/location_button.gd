extends Button

@export var menu : GeneralMenu
@export var location : PackedScene

func _on_pressed():
	if(is_instance_valid(location)):
		var new_menu = location.instantiate()
		new_menu.prev = menu
		get_tree().current_scene.add_child(new_menu)
	else:
		if(is_instance_valid(menu.prev)):
			menu.prev.show()
		menu.close()
