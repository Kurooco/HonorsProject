extends CharacterBody2D


@export var SPEED = 25.0
@export var ATTACK_SPEED = 15
@export var MAX_JUMP_VELOCITY = -500.0
@export var JUMP_VELOCITY_DECLINE = 80
@export var BOUNCE_VELOCITY = -400
@export var PURSUIT_THRESHOLD_RATIO = .5
@export var GRAVITY_DAMP = 2.0

var jump_velocity = MAX_JUMP_VELOCITY
var consecutive_bounces = 0
var can_jump = true
var current_speed = SPEED
var on_screen = false
var impact = Vector2.ZERO

func _ready():
	set_physics_process(false)

func _physics_process(delta):
	# Find target
	var target = null
	if(jump_velocity > MAX_JUMP_VELOCITY*PURSUIT_THRESHOLD_RATIO):
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
		
	# Apply impact from enemies
	if(impact != Vector2.ZERO):
		velocity += impact
		impact = Vector2.ZERO
		
	# Update impact
	$WeaponArea.impact = Vector2(velocity.x * 10, 0)
	
	# Add the gravity.
	var camera = get_viewport().get_camera_2d()
	var zoom = get_viewport().get_camera_2d().zoom.x
	if not is_on_floor():
		velocity += get_gravity() * delta #* (acorns/6 + 1)
	var relative_position = position - camera.position
	if(relative_position.y < -(get_viewport().size.y/zoom/2)):
		velocity += get_gravity() * delta * 2
	
	if(target != null):
		# Handle jump.
		if(is_on_floor()):
			jump_velocity = MAX_JUMP_VELOCITY 
		# Jump
		if(target.position.y < position.y-50 && jump_velocity <= 0 && can_jump):
			velocity.y = jump_velocity
			jump_velocity += JUMP_VELOCITY_DECLINE
			can_jump = false
			$JumpTimer.start()
			$Sprite2D.play("flap")

		# Move left and right
		var direction = abs(target.position.x - position.x)/(target.position.x - position.x)
		if direction:
			velocity.x += direction * current_speed
			$Sprite2D.flip_h = direction == -1
		velocity.x = lerp(velocity.x, 0.0, 1 - pow(.005, delta))
		
		#Avoid other enemies
		for enemy in get_tree().get_nodes_in_group("enemy"):
			if(enemy.on_screen && enemy != self && position.distance_squared_to(enemy.position) != 0):
				var vel_change : Vector2 = (position - enemy.position)/(position.distance_squared_to(enemy.position)*.001)
				var cut = 100
				if vel_change.length() > cut:
					vel_change = vel_change.normalized()*cut
				if vel_change.length() < -cut:
					vel_change = vel_change.normalized()*(-cut)
				velocity += vel_change
		
		if(velocity.y > 0):
			$Sprite2D.play("fall")
		elif($Sprite2D.animation != "flap"):
			$Sprite2D.play("flap")

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


func apply_impact(i: Vector2):
	impact += i
