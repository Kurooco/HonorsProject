extends Node2D

@export var speed = 1

func _process(delta):
	rotate(delta*speed)
