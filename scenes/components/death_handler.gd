extends Node

@export var scene_root : Node
@export var health_component : HealthComponent
@export var point_worth : int

# Called when the node enters the scene tree for the first time.
func _ready():
	health_component.killed.connect(die)


func die():
	if(point_worth > 0):
		await $PointAwarder.award_points(point_worth)
	scene_root.queue_free()
	
