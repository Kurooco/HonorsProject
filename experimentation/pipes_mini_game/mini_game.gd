extends Node2D

var started = false
var enabled = true

signal won
signal exit

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Input.is_anything_pressed() && !started && enabled):
		started = true
		start()

func start():
	for i in get_children():
		if i is CharacterBody2D:
			i.set_physics_process(true)

func enable():
	await tree_entered
	await get_tree().create_timer(1.0).timeout
	enabled = true
	print_debug("ready!")


func _on_goal_body_entered(body: Node2D) -> void:
	for i in get_children():
		if i is CharacterBody2D:
			i.set_physics_process(false)
	won.emit()
	exit.emit()

func restart():
	var new_game = load(scene_file_path).instantiate()
	new_game.scene_file_path = scene_file_path
	new_game.enabled = false
	new_game.enable()
	new_game.transform = transform
	get_parent().add_child(new_game)
	get_parent().remove_child(self)


func _on_area_2d_body_entered(body: Node2D) -> void:
	call_deferred("restart")
