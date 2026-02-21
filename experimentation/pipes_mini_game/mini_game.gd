extends Node2D

var started = false
var enabled = true

signal won
signal exit
signal restarted

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Input.is_anything_pressed() && !started && enabled):
		started = true
		start()

func start():
	for i in get_children():
		if i is Area2D:
			i.set_process(true)
	$Player.set_physics_process(true)

func enable():
	await tree_entered
	await get_tree().create_timer(1.0).timeout
	enabled = true

func _on_goal_body_entered(body: Node2D) -> void:
	for i in get_children():
		if i is Area2D:
			i.set_process(false)
	$Player.set_physics_process(false)
	won.emit()
	exit.emit()

func restart():
	restarted.emit()


func _on_area_2d_area_entered(area: Area2D) -> void:
	call_deferred("restart")
