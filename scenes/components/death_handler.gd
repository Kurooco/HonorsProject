extends Node

@export var scene_root : Node
@export var health_component : HealthComponent
@export var point_awarder : Node
@export var point_worth : int

# Called when the node enters the scene tree for the first time.
func _ready():
	health_component.killed.connect(die)


func die():
	scene_root.queue_free()
	if(is_instance_valid(point_awarder)):
		point_awarder.award_points(point_worth)
