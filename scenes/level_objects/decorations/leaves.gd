extends Sprite2D

var rotate_offset
var rotate_timer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	rotate_offset = randf_range(0, PI)
	seed(position.length())
	var size = randf_range(.8, 1.2)
	scale = Vector2(size, size)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate_timer += delta
	rotation = sin(rotate_timer/2.0 + rotate_offset)/2.0 + rotate_offset
