@tool
extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Sprite2D.scale.x = sin(Time.get_ticks_msec()/50.0)*.5
	$Sprite2D2.position = Vector2(randi_range(-2, 2), randi_range(-2, 2))
