extends Area2D

@onready var fan = $".."
var strength = 240000

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for i:PhysicsBody2D in get_overlapping_bodies():
		if(i.is_physics_processing()):
			i.velocity += (Vector2(cos(fan.rotation - PI/2), sin(fan.rotation - PI/2))*strength)/(fan.position.distance_to(i.position))*delta
# i.velocity += (Vector2(cos(fan.rotation - PI/2), sin(fan.rotation - PI/2))*strength)/(fan.position.distance_to(i.position))
