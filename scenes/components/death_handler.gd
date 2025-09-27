extends Node

@export var scene_root : Node
@export var health_component : HealthComponent

# Called when the node enters the scene tree for the first time.
func _ready():
	health_component.killed.connect(die)


func die():
	scene_root.queue_free()
