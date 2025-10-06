extends "res://scenes/player/collectable.gd"

@export var value = 1


func _on_collected():
	$PointAwarder.award_points(value)
	queue_free()
