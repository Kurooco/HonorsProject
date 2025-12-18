extends CanvasLayer

func _ready():
	$Menu.hide()

func _on_pause_button_pressed():
	Autoload.level_handler.pause_game(true)
	$Menu.show()

func _on_continue_pressed():
	Autoload.level_handler.pause_game(false)
	$Menu.hide()
