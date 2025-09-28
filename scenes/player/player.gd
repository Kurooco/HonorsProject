extends CharacterBody2D


const SPEED = 50.0
const MAX_JUMP_VELOCITY = -500.0
const JUMP_VELOCITY_DECLINE = 80
const BOUNCE_VELOCITY = -400

var jump_velocity = MAX_JUMP_VELOCITY
var last_direction = 1
var consecutive_bounces = 0
var max_acorns = 5
var acorns = 0
var impact = Vector2.ZERO
@onready var health_component = $HealthComponent

func _ready():
	Autoload.player = self


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta #* (acorns/6 + 1)
	var relative_position = position - get_viewport().get_camera_2d().position
	if(relative_position.y < -get_viewport_rect().size.y/2):
		velocity += get_gravity() * delta * 2
	
	# Out of bounds death
	if(position.y > get_viewport().get_camera_2d().position.y + get_viewport_rect().size.y/2.0
		|| position.x < get_viewport().get_camera_2d().position.x - get_viewport_rect().size.x):
		$HealthComponent.kill()
		set_physics_process(false)
	
	# Apply impact from enemies
	if(impact != Vector2.ZERO):
		velocity += impact
		impact = Vector2.ZERO

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
		last_direction = direction
		velocity.x += direction * SPEED
	velocity.x = lerp(velocity.x, 0.0, 1 - pow(.005, delta))
	
	if($HurtBox.currently_invincible):
		modulate = Color(1, 1, 1, .5)
	else:
		modulate = Color.WHITE
		
	if(Input.is_action_just_pressed("shoot") && acorns > 0):
		shoot_acorn(last_direction)
	
	move_and_slide()


func _on_detection_area_area_entered(area):
	if(area is Food):
		if(!Input.is_action_pressed("dive")):
			velocity.y = MAX_JUMP_VELOCITY
		jump_velocity = MAX_JUMP_VELOCITY
		area.jump_on()
		consecutive_bounces += 1
		$PointAwarder.award_points(10*min(consecutive_bounces, 10))
	elif(area is Acorn && acorns < max_acorns): # && Input.is_action_pressed("shoot") && 
		area.collect()
		acorns += 1
	elif(area is Collectable && area.autocollect):
		area.collect()


func shoot_acorn(dir):
	var new_acorn = load("res://scenes/player/acorn_projectile.tscn").instantiate()
	new_acorn.direction = dir
	new_acorn.global_position = global_position
	Autoload.level_handler.current_level.add_child(new_acorn)
	acorns -= 1


func apply_impact(i: Vector2):
	impact += i


func _on_health_component_killed():
	hide()
	Autoload.level_handler.restart_level()
