extends "res://scenes/player/collectable.gd"

const GRAVITY = 500

var velocity : Vector2
var birth_y : float

func _ready():
	birth_y = position.y

func _process(delta):
	velocity.y += delta*GRAVITY
	position += velocity*delta
	if(position.y > birth_y):
		queue_free()
