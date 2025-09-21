extends Area2D
class_name Food

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

func jump_on():
	velocity.y = 700
	set_deferred("monitorable", false)
	"""var pa = load("res://scenes/ui/point_awarder.tscn").instantiate()
	pa.global_position = global_position
	get_tree().current_scene.add_child(pa)
	pa.award_points(10)"""
