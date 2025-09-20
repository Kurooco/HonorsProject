extends Area2D
class_name Food

const GRAVITY = 500

var velocity : Vector2


func _process(delta):
	velocity.y += delta*GRAVITY
	position += velocity*delta

func jump_on():
	velocity.y = 700
	set_deferred("monitorable", false)
