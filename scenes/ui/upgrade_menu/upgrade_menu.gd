extends CanvasLayer

@onready var upgrade_options = $Panel/MarginContainer/VBoxContainer/UpgradeOptions


func _on_x_button_pressed():
	hide()
	Autoload.set_player_disabled(false)


func _on_visibility_changed():
	if(visible):
		for child in upgrade_options.get_children():
			child.update_display()
