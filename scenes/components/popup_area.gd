extends "res://scenes/components/interaction_area.gd"

@export var popup : PackedScene

func _on_activated():
	var p = popup.instantiate()
	get_tree().current_scene.add_child(p)
