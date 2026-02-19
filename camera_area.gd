extends "res://scenes/components/interaction_area.gd"

enum Type
{
	DEFOCUS = 0,
	FOCUS = 1,
	FOCUS_ON_PLAYER = 2
}

@export var focus_position : Vector2
@export var focus_zoom = Vector2(1.0, 1.0)
@export var type : Type

func _on_activated() -> void:
	match type:
		0:
			get_tree().get_first_node_in_group("level_camera").defocus()
		1:
			get_tree().get_first_node_in_group("level_camera").focus(focus_position, focus_zoom)
		2:
			get_tree().get_first_node_in_group("level_camera").focus_on_player(focus_zoom)
