extends "res://scenes/levels/rest_1.gd"

@onready var camera = $Camera2D
@onready var player = $Player
@onready var acorn_shooter = $Shooters/AcornShooter
@onready var block = $Block

# Called when the node enters the scene tree for the first time.
func _ready():
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_tutorial_star_captured(ind):
	match ind:
		2:
			acorn_shooter.position = Vector2(280, 540)
		7:
			var t = create_tween()
			t.tween_property(block, "position", block.position+Vector2(0, -500), 1)


func _on_camera_area_activated():
	camera.focus_on_player(1.5)


func _on_camera_area_2_activated():
	camera.focus_on_point(Vector2(1300, -380), 1)


func _on_camera_area_3_activated():
	camera.focus_on_point(Vector2(2420, -640), 1)


func _on_level_end_activated():
	PlayerStats.run_points = 0
	PlayerStats.sync_points()
