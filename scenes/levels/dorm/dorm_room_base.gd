extends "res://scenes/levels/rest_1.gd"

@export var deleted_nodes_during_day : Array[Node]
@export var deleted_nodes_during_night : Array[Node]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	if(!PlayerStats.nighttime):
		for node in deleted_nodes_during_day:
			node.queue_free()
	else:
		for node in deleted_nodes_during_night:
			node.queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
