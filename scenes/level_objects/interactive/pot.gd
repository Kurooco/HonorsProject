extends RigidBody2D


func _on_area_2d_body_entered(body):
	print(linear_velocity)
	if(body.is_in_group("player")):
		var dir = -1 if body.position.x > position.x else 1
		apply_impulse(Vector2(400*dir, -400))
	elif(linear_velocity.length() > 300):
		queue_free()
