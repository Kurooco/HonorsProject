extends "res://scenes/ui/general_menu/general_menu.gd"


func _on_continue_pressed() -> void:
	Autoload.level_handler.new_game()
	queue_free()
