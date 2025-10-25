extends Camera2D

@export var speed = 100
var speed_tween : Tween = null

func _ready():
	set_process(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += speed*delta

func start():
	set_process(true)

func change_speed(s):
	if(is_instance_valid(speed_tween)):
		speed_tween.kill()
	speed_tween = create_tween()
	speed_tween.tween_property(self, "speed", s, 2)
