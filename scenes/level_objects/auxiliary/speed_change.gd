extends Sprite2D

@export var speed = 100

func _ready():
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(get_viewport().get_camera_2d().position.x > position.x):
		get_viewport().get_camera_2d().change_speed(speed)
		queue_free()
