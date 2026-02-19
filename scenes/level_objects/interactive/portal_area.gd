extends Area2D

@export var new_position : Vector2


func _on_area_entered(area: Area2D) -> void:
	Autoload.level_handler.restart_level(new_position)
