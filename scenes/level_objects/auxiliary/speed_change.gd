extends Sprite2D

@export var speed = 100

func _ready():
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var camera_x = get_viewport().get_camera_2d().position.x
	if(camera_x > position.x && camera_x < position.x+get_viewport_rect().size.x/2):
		get_viewport().get_camera_2d().change_speed(speed)
		print_debug("changed speed to "+str(speed))
		queue_free()
