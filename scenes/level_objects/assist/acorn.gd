extends "res://scenes/player/collectable.gd"
class_name Acorn

func collect():
	super()
	MusicHandler.play_single_polyphony_sound(position, "res://sound/sfx/game sounds/sfx4.wav")
	queue_free()

func _process(delta):
	rotation += delta*2
