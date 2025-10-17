extends Area2D

@onready var fan = $".."
var strength = 4000

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for i in get_overlapping_bodies():
		i.velocity += (Vector2(cos(fan.rotation - PI/2), sin(fan.rotation - PI/2))*strength)/(fan.position.distance_to(i.position))
