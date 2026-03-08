extends Node2D

@onready var cage: AnimatableBody2D = $Cage
@onready var camera: Camera2D = $Camera2D
var loaded = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if(loaded):
		$Cheese.queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_interaction_area_activated() -> void:
	camera.focus_on_player(Vector2(2, 2), 10)
	cage.move_down(.2)
	await get_tree().create_timer(2).timeout
	Dialogic.start("caged")
	await $DialogicSignalHandler.matched
	await get_tree().create_timer(2).timeout
	cage.set_bottom(false)
	cage.move_up(10)
	await cage.finished_moving
	cage.open_door(true)

func on_load():
	loaded = true
