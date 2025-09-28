extends "res://scenes/player/collectable.gd"



func _on_collected():
	$PointAwarder.award_points(1)
	queue_free()
