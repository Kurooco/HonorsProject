extends Camera2D

@export var speed = 100

func _ready():
	set_process(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += speed*delta

func start():
	set_process(true)
