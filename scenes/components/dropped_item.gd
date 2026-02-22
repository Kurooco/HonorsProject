extends CharacterBody2D

@export var scene : PackedScene
const SPEED = 300.0
var bounce = -400.0

func _ready():
	velocity.y = randf_range(-400, -100)
	bounce = velocity.y
	velocity.x = randf_range(-100, 100)
	$Coin.remove_from_group("saveable")
	$Coin.gathered.connect(queue_free)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if is_on_floor():
		if(bounce < -1):
			$HitSound.play()
		velocity.y = bounce
		bounce = min(0, bounce+80)
		velocity.x = lerp(velocity.x, 0.0, 1 - pow(.005, delta))

	move_and_slide()
