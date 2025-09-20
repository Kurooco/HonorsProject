extends CharacterBody2D


const SPEED = 300.0
const MAX_JUMP_VELOCITY = -500.0
const JUMP_VELOCITY_DECLINE = 80

var jump_velocity = MAX_JUMP_VELOCITY

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if(is_on_floor()):
		jump_velocity = MAX_JUMP_VELOCITY
	if(Input.is_action_just_pressed("jump") && jump_velocity <= 0):
		velocity.y = jump_velocity
		jump_velocity += JUMP_VELOCITY_DECLINE

	# Move left and right
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
