extends Area2D

@export var strength = 4800

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for i:PhysicsBody2D in get_overlapping_bodies():
		if(i.is_physics_processing()):
			i.velocity += (Vector2(cos(rotation), sin(rotation))*strength)*delta
