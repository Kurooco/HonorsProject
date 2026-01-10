extends Node

@export var scene_root : Node2D
@export var health_component : HealthComponent
@export var particles : CPUParticles2D
@export var point_worth : int

signal died

# Called when the node enters the scene tree for the first time.
func _ready():
	health_component.killed.connect(die)


func die():
	if(point_worth > 0):
		await $PointAwarder.award_points(point_worth)
	if(is_instance_valid(particles)):
		scene_root.remove_child(particles)
		get_tree().current_scene.add_child(particles)
		particles.global_position = scene_root.global_position
		particles.one_shot = true
		particles.emitting = true
	died.emit()
	print_debug(scene_root.name+" died")
	scene_root.queue_free()
	
