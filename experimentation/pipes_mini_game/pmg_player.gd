extends CharacterBody2D


const SPEED = 50.0
const JUMP_VELOCITY = -400.0

func _ready():
	set_physics_process(false)

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x += direction * SPEED
	direction = Input.get_axis("jump", "dive")
	if direction:
		velocity.y += direction * SPEED
	
	velocity = lerp(velocity, Vector2.ZERO, 1 - pow(.00005, delta))

	move_and_slide()
