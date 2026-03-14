extends Node2D

@export var wake_up_area : Area2D
@onready var color_rect: ColorRect = $CanvasLayer/ColorRect
@onready var camera_2d: Camera2D = $Player/Camera2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	wake_up_area.area_entered.connect(wake_up)
	AudioServer.set_bus_layout(load("res://sound/bus_layouts/dream_bus_layout.tres"))

func _process(delta: float) -> void:
	color_rect.set_instance_shader_parameter("camera_pos", camera_2d.get_screen_center_position())
	

func wake_up(area):
	AudioServer.set_bus_layout(load("res://sound/bus_layouts/default_bus_layout.tres"))
	PlayerStats.nighttime = false
	Autoload.level_handler.set_level_with_spawn_point("res://scenes/levels/dorm/dorm_room2.tscn", "bed", false)


func _on_bird_timer_timeout() -> void:
	var bx = randi_range(1000, 2500)
	var bird = load("res://experimentation/flyer.tscn").instantiate()
	bird.position = Vector2(bx, 800)
	add_child(bird)
