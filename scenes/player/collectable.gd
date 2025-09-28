extends Area2D
class_name Collectable

@export var particles : CPUParticles2D

signal collected

func collect():
	if(is_instance_valid(particles)):
		remove_child(particles)
		particles.global_position = global_position
		particles.one_shot = true
		particles.emitting = true
		Autoload.level_handler.add_child(particles)
	collected.emit()
