extends "res://scenes/player/collectable.gd"

@export var value = 1
#var tilemap : TileMapLayer
#var coordinates : Vector2i

signal gathered

func _on_collected():
	#tilemap.erase_cell(coordinates)
	MusicHandler.play_single_polyphony_sound(global_position, "res://sound/sfx/game sounds/coin.wav")
	$PointAwarder.award_points(value)
	gathered.emit()
	queue_free()
