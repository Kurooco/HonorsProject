extends Line2D

enum MovementType
{
	LINEAR = 0,
	SIN = 1
}

@export var scene : PackedScene
@export var number = 1
@export var speed = 10.0
@export var movement_type : MovementType
var followers : Array[PathFollow2D]

func _ready():
	var path = Path2D.new()
	var c = Curve2D.new()
	for point in points:
		c.add_point(point)
	if(closed):
		c.add_point(points[0])
		gradient = load("res://art/styles/line_follower_cyclic.tres")
	path.curve = c
	add_child(path)
	for i in range(number):
		var follower = PathFollow2D.new()
		follower.rotates = false
		follower.add_child(scene.instantiate())
		followers.append(follower)
		path.add_child(follower)
	
func _process(delta):
	var ind = 0
	for follower in followers:
		var offset
		if(movement_type == MovementType.SIN):
			offset = 2*PI*ind/followers.size()
			follower.progress_ratio = .5 + cos((Time.get_ticks_msec()/5000.0)*speed + offset)/2.0
		else:
			offset = float(ind)/followers.size()
			follower.progress_ratio = ((Time.get_ticks_msec()/5000.0)*speed) + offset
		ind += 1
