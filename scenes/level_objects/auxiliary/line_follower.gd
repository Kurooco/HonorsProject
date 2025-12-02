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
var follower : PathFollow2D

func _ready():
	var path = Path2D.new()
	var c = Curve2D.new()
	for point in points:
		c.add_point(point)
	path.curve = c
	add_child(path)
	for i in range(number):
		follower = PathFollow2D.new()
		follower.rotates = false
		follower.add_child(scene.instantiate())
		path.add_child(follower)
	
func _process(delta):
	if(movement_type == MovementType.SIN):
		follower.progress_ratio = .5 + cos((Time.get_ticks_msec()/5000.0)*speed)/2.0
	else:
		follower.progress_ratio = ((Time.get_ticks_msec()/5000.0)*speed)
