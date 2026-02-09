extends Control

@onready var group_number = $PanelContainer/MarginContainer/VBoxContainer/GroupNumber


func _on_without_pressed():
	Autoload.group = group_number.selected
	Autoload.level_handler.begin()


func _on_with_pressed():
	DataCollector.enable()
	DataCollector.set_stat("group", group_number.selected)
	Autoload.group = group_number.selected
	if(Autoload.group == 0):
		get_tree().quit()
	print_debug(Autoload.group)
	Autoload.level_handler.begin()
