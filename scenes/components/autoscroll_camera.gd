extends Camera2D

@export var speed = 100
var speed_tween : Tween = null
var running = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("jump")):
		running = true
	if(running):
		position.x += speed*delta

func start():
	set_process(true)

func change_speed(s):
	if(is_instance_valid(speed_tween)):
		speed_tween.kill()
	speed_tween = create_tween()
	speed_tween.tween_property(self, "speed", s, 2)
