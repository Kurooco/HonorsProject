extends Node2D

@export var wake_up_area : Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	wake_up_area.area_entered.connect(wake_up)


func wake_up(area):
	PlayerStats.nighttime = false
	Autoload.level_handler.set_level_with_spawn_point("res://scenes/levels/dorm/dorm_room2.tscn", "bed", false)
