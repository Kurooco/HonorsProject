extends RigidBody2D


func _on_area_2d_body_entered(body):
	if(body.is_in_group("player")):
		var dir = -1 if body.position.x > position.x else 1
		apply_impulse(Vector2(200*dir, -400))
	elif(linear_velocity.length() > 300):
		shatter()

func shatter():
	for i in range(10):
		var coin = load("res://scenes/components/dropped_item.tscn").instantiate()
		coin.scene = load("res://scenes/level_objects/assist/coin.tscn")
		coin.global_position = global_position
		Autoload.level_handler.current_level.call_deferred("add_child", coin)
	queue_free()
