extends Area2D
class_name Food

@export var points = 10
@export var bounce_amount = -500
@export var bounce = true

var consumed = false

func jump_on():
	if(!consumed):
		set_undetectable(true)
		$Sound.play()
		for child in get_children():
			if child is ArcMover:
				child.queue_free()
		disappear()

func set_undetectable(b):
	consumed = b
	set_deferred("monitorable", !b)
	if(b):
		remove_from_group("food")
	else:
		add_to_group("food")

func disappear():
	if(get_parent() != null):
		call_deferred("reparent", get_tree().current_scene)
		
	var am = ArcMover.new()
	am.velocity = Vector2(0, 700)
	am.birth_y = get_viewport_rect().size.y
	am.move_object = self
	add_child(am)
	
