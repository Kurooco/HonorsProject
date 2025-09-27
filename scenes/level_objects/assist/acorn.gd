extends "res://scenes/player/collectable.gd"
class_name Acorn

func collect():
	super()
	queue_free()

func _process(delta):
	rotation += delta*2
