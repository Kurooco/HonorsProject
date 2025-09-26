extends Node2D

const CAMERA_SPEED = 100

func _process(delta):
	$Camera2D.position.x += delta * CAMERA_SPEED
