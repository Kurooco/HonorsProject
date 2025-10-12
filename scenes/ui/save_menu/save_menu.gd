extends CanvasLayer

@onready var text = $Panel/MarginContainer/VBoxContainer/Text
@onready var save_game = $Panel/MarginContainer/VBoxContainer/HBoxContainer/SaveGame
@onready var cancel = $Panel/MarginContainer/VBoxContainer/HBoxContainer/Cancel

func _ready():
	Autoload.set_player_disabled(true)

func _on_cancel_pressed():
	Autoload.set_player_disabled(false)
	queue_free()


func _on_save_game_pressed():
	Autoload.level_handler.game_saver.save_level()
	Autoload.level_handler.game_saver.save_game(0)
	text.text = "Saved!"
	save_game.hide()
	cancel.text = "Continue"
	
	
func _on_button_pressed():
	Autoload.level_handler.game_saver.clear_slot(0)
