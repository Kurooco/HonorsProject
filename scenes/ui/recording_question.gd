extends Control

@onready var group_number = $PanelContainer/MarginContainer/VBoxContainer/GroupNumber


func _on_without_pressed():
	Autoload.level_handler.begin()


func _on_with_pressed():
	DataCollector.enable()
	Autoload.group = int(group_number.text)
	if(Autoload.group == 0):
		get_tree().quit()
	print_debug(Autoload.group)
	Autoload.level_handler.begin()
