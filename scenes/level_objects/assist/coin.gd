extends "res://scenes/player/collectable.gd"

@export var value = 1
#var tilemap : TileMapLayer
#var coordinates : Vector2i

func _on_collected():
	#tilemap.erase_cell(coordinates)
	$GlobalSound.play()
	$PointAwarder.award_points(value)
	queue_free()
