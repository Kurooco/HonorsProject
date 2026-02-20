extends CharacterBody2D


@export var SPEED = 30.0

@export var player: CharacterBody2D
var avoid_vel = Vector2.ZERO

func _ready():
	set_physics_process(false)

func _physics_process(delta: float) -> void:
	$NavigationAgent2D.target_position = player.position
	var next : Vector2 = $NavigationAgent2D.get_next_path_position()
	velocity += position.direction_to(next) * SPEED + avoid_vel
	velocity = lerp(velocity, Vector2.ZERO, 1 - pow(.00005, delta))
	move_and_slide()

func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	avoid_vel = safe_velocity
