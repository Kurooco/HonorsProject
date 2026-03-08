extends Node2D

@onready var cage: Sprite2D = $Cage
@onready var camera: Camera2D = $Camera2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_interaction_area_activated() -> void:
	camera.focus_on_player(Vector2(2, 2), 10)
	var t : Tween = create_tween()
	t.tween_property(cage, "global_position:y", 152, .2)
	t.finished.connect(cage.set_bottom.bind(false))
	await get_tree().create_timer(2).timeout
	Dialogic.start("caged")
	await $DialogicSignalHandler.matched
	await get_tree().create_timer(2).timeout
	t = create_tween()
	t.tween_property(cage, "global_position:y", -1192, 10)
	await t.finished
	cage.open_door(true)
