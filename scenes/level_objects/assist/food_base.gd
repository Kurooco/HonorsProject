extends Area2D
class_name Food

@export var sound : AudioStream
@export var points = 10
@export var bounce = -500

var consumed = false

func _ready() -> void:
	if(is_instance_valid(sound)):
		$Sound.stream = sound

func jump_on():
	if(!consumed):
		$Sound.play()
		consumed = true
		for child in get_children():
			if child is ArcMover:
				child.queue_free()
		make_undetectable()
		disappear()

func make_undetectable():
	set_deferred("monitorable", false)
	remove_from_group("food")
	if(get_parent() != null):
		call_deferred("reparent", get_tree().current_scene)

func disappear():
	var am = ArcMover.new()
	am.velocity = Vector2(0, 700)
	am.birth_y = get_viewport_rect().size.y
	am.move_object = self
	add_child(am)
	
