extends CharacterBody2D


const SPEED = 25.0
const ATTACK_SPEED = 15
const MAX_JUMP_VELOCITY = -500.0
const JUMP_VELOCITY_DECLINE = 100
const BOUNCE_VELOCITY = -400

var jump_velocity = MAX_JUMP_VELOCITY
var consecutive_bounces = 0
var acorns = 0
var can_jump = true
var current_speed = SPEED
var on_screen = false

func _ready():
	set_physics_process(false)

func _physics_process(delta):
	# Find target
	var target = null
	if(jump_velocity > MAX_JUMP_VELOCITY/2):
		var min_dist = INF
		var closest_food = null
		for i in get_tree().get_nodes_in_group("food"):
			if(global_position.distance_to(i.global_position) < min_dist):
				min_dist = global_position.distance_to(i.global_position)
				closest_food = i
		target = closest_food
		current_speed = SPEED
	else:
		target = Autoload.player
		current_speed = ATTACK_SPEED
		
	# Update impact
	$WeaponArea.impact = Vector2(velocity.x * 20, 0)
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * (acorns/3 + 1)
	var relative_position = position - get_viewport().get_camera_2d().position
	if(relative_position.y < -get_viewport_rect().size.y/2):
		velocity += get_gravity() * delta * 2
	
	if(target != null):
		# Handle jump.
		if(is_on_floor()):
			jump_velocity = MAX_JUMP_VELOCITY 
		if(target.position.y < position.y && jump_velocity <= 0 && can_jump):
			velocity.y = jump_velocity
			jump_velocity += JUMP_VELOCITY_DECLINE
			can_jump = false
			$JumpTimer.start()

		# Move left and right
		var direction = abs(target.position.x - position.x)/(target.position.x - position.x)
		if direction:
			velocity.x += direction * current_speed
		velocity.x = lerp(velocity.x, 0.0, 1 - pow(.005, delta))
		
		#Avoid other enemies
		for enemy in get_tree().get_nodes_in_group("enemy"):
			if(enemy.on_screen && enemy != self):
				velocity += (position - enemy.position)/(position.distance_squared_to(enemy.position)*.001)
	
	move_and_slide()


func _on_detection_area_area_entered(area):
	if(area is Food):
		velocity.y = MAX_JUMP_VELOCITY
		jump_velocity = MAX_JUMP_VELOCITY
		area.jump_on()


func _on_jump_timer_timeout():
	can_jump = true


func _on_visible_on_screen_notifier_2d_screen_entered():
	set_physics_process(true)
	on_screen = true
