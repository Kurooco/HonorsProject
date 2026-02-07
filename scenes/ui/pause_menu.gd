extends CanvasLayer

@onready var back_to_safe_zone = $Menu/MarginContainer/VBoxContainer/BackToSafeZone

func _ready():
	$Menu.hide()

func _on_pause_button_pressed():
	Autoload.level_handler.pause_game(true)
	$Menu.show()

func _on_continue_pressed():
	if($Menu.visible):
		Autoload.level_handler.pause_game(false)
		$Menu.hide()

func _on_quit_pressed():
	Autoload.level_handler.set_level("res://scenes/ui/main_menu.tscn")
	Autoload.level_handler.pause_game(false)
	$Menu.hide()


func _on_back_to_safe_zone_pressed():
	Autoload.level_handler.fade_out()
	await Autoload.level_handler.fade_ended
	Autoload.level_handler.set_level(Autoload.level_handler.last_rest_level_visited.resource_path)
	$Menu.hide()
	Autoload.level_handler.fade_in()
