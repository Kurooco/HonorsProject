extends Control


func _on_without_pressed():
	Autoload.level_handler.begin()


func _on_with_pressed():
	DataCollector.enable()
	Autoload.level_handler.begin()
