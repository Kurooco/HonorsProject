extends CharacterBody2D


const SPEED = 50.0
const MAX_JUMP_VELOCITY = -500.0
const JUMP_VELOCITY_DECLINE = 80
const BOUNCE_VELOCITY = -400

var jump_velocity = MAX_JUMP_VELOCITY
var consecutive_bounces = 0
var acorns = 0

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * (acorns/3 + 1)
	var relative_position = position - get_viewport().get_camera_2d().position
	if(relative_position.y < -get_viewport_rect().size.y/2):
		velocity += get_gravity() * delta * 2

	# Handle jump.
	if(is_on_floor()):
		jump_velocity = MAX_JUMP_VELOCITY
		consecutive_bounces = 0
	if(Input.is_action_just_pressed("jump") && jump_velocity <= 0):
		velocity.y = jump_velocity
		jump_velocity += JUMP_VELOCITY_DECLINE
		consecutive_bounces = 0

	# Move left and right
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x += direction * SPEED
	velocity.x = lerp(velocity.x, 0.0, 1 - pow(.005, delta))
	
	move_and_slide()


func _on_detection_area_area_entered(area):
	if(area is Food):
		velocity.y = MAX_JUMP_VELOCITY
		jump_velocity = MAX_JUMP_VELOCITY
		area.jump_on()
		consecutive_bounces += 1
		$PointAwarder.award_points(10*min(consecutive_bounces, 10))
	elif(area is Acorn && Input.is_action_pressed("shoot")):
		area.collect()
		acorns += 1
