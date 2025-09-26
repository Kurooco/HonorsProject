extends Node2D
class_name ArcMover

@export var move_object : Node
const GRAVITY = 500
var velocity : Vector2
var birth_y : float

func _ready():
	birth_y = move_object.position.y

func _process(delta):
	velocity.y += delta*GRAVITY
	move_object.position += velocity*delta
	if(velocity.y > 0 && move_object.position.y > get_viewport().get_camera_2d().position.y+get_viewport_rect().size.y/2):
		move_object.queue_free()
