extends Area2D
class_name Food

var consumed = false

func jump_on():
	if(!consumed):
		$AudioStreamPlayer2D.play()
		consumed = true
		for child in get_children():
			if child is ArcMover:
				child.queue_free()
		var am = ArcMover.new()
		am.velocity = Vector2(0, 700)
		am.birth_y = get_viewport_rect().size.y
		am.move_object = self
		add_child(am)
		set_deferred("monitorable", false)
		remove_from_group("food")
		if(get_parent() != null):
			call_deferred("reparent", get_tree().current_scene)
