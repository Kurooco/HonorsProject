extends CharacterBody2D


const SPEED = 50.0
const MAX_JUMP_VELOCITY = -500.0
const BOUNCE_VELOCITY = -400
const ACORN_ENERGY_DECREASE = 8

var jump_velocity = MAX_JUMP_VELOCITY
var last_direction = 1
var consecutive_bounces = 0
var acorns = 0
var acorn_energy = 0
var impact = Vector2.ZERO
var disabled = false

# base stats
const BASE_MAX_ACORNS = 3
const BASE_JUMP_VELOCITY_DECLINE = 80
const BASE_MAX_LIVES = 3

# current stats
var max_acorns
var jump_velocity_decline

@export var waiting_for_start = true
@onready var health_component = $HealthComponent

func _ready():
	Autoload.player = self
	update_stats()
	Dialogic.signal_event.connect(handle_dialogic_signals)


func _physics_process(delta):
	if(Input.is_action_just_pressed("jump") && waiting_for_start):
		waiting_for_start = false
	if(waiting_for_start):
		return
	
	# Add the gravity.
	var camera = get_viewport().get_camera_2d()
	var zoom = get_viewport().get_camera_2d().zoom.x
	if not is_on_floor():
		velocity += get_gravity() * delta #* (acorns/6 + 1)
	var relative_position = position - camera.position
	if(relative_position.y < -(get_viewport().size.y/zoom/2)):
		velocity += get_gravity() * delta * 2
	
	# Out of bounds death
	if(!Autoload.level_handler.in_rest_level && (global_position.y > camera.global_position.y + get_viewport_rect().size.y/zoom/2.0
		|| position.x < camera.position.x - get_viewport_rect().size.x/zoom)):
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
	if(Input.is_action_just_pressed("jump") && jump_velocity <= 0 && !disabled && Dialogic.current_timeline == null):
		velocity.y = jump_velocity
		jump_velocity += jump_velocity_decline
		consecutive_bounces = 0

	# Move left and right
	if(!disabled && Dialogic.current_timeline == null):
		var direction = Input.get_axis("left", "right")
		if direction:
			last_direction = direction
			velocity.x += direction * SPEED
		velocity.x = lerp(velocity.x, 0.0, 1 - pow(.005, delta))
	
	# Handle Interactions
	if(Input.is_action_just_pressed("interact")):
		activate_interactive_areas()
	var areas_inside = false
	for area in $DetectionArea.get_overlapping_areas():
		if(area is InteractionArea && area.show_prompt && !area.activated_since_entering):
			areas_inside = true
	$Prompt.visible = areas_inside
	
	if($HurtBox.currently_invincible):
		modulate = Color(1, 1, 1, .5)
	else:
		modulate = Color.WHITE
		
	if(Input.is_action_just_pressed("shoot") && acorns > 0 && Dialogic.current_timeline == null):
		shoot_acorn(last_direction)
		
	# Update acorn energy
	if(acorn_energy > 0):
		acorn_energy -= delta*ACORN_ENERGY_DECREASE
		acorns = max_acorns
	else:
		acorn_energy = 0
	
	if(!disabled && Dialogic.current_timeline == null):
		move_and_slide()


func _on_detection_area_area_entered(area):
	if(waiting_for_start || disabled):
		return
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
	elif(area is InteractionArea):
		area.enter()
	elif(area is Collectable && area.autocollect):
		area.collect()


func _on_detection_area_area_exited(area):
	if(area is InteractionArea):
		area.exit()


func shoot_acorn(dir):
	var new_acorn = load("res://scenes/player/acorn_projectile.tscn").instantiate()
	new_acorn.direction = dir
	new_acorn.global_position = global_position
	Autoload.level_handler.current_level.add_child(new_acorn)
	acorns -= 1


func apply_impact(i: Vector2):
	impact += i


func _on_health_component_killed():
	Autoload.level_handler.restart_level()
	queue_free()


func activate_interactive_areas():
	if(disabled || Dialogic.current_timeline != null):
		return
	for area in $DetectionArea.get_overlapping_areas():
		if(area is InteractionArea):
			area.activate()

func update_stats():
	health_component.max_health = BASE_MAX_LIVES + PlayerStats.lives
	health_component.health = health_component.max_health
	jump_velocity_decline = BASE_JUMP_VELOCITY_DECLINE + PlayerStats.jumps*-10
	max_acorns = PlayerStats.acorns + BASE_MAX_ACORNS

func make_invincible():
	health_component.invincible = true

func handle_dialogic_signals(arg):
	match arg:
		"acorn_for_beer":
			acorns = min(acorns+1, max_acorns)


func _on_hurt_box_hurt():
	$Blood.emitting = true
