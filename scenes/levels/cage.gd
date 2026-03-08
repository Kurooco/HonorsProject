extends AnimatableBody2D

#var class_of_object = "Sprite2D"
@onready var bottom_collision: CollisionShape2D = $BottomCollision
@onready var door: CollisionShape2D = $Door
var loaded = false

signal finished_moving

func _ready():
	if(loaded):
		$DoorCloser.disabled = false
		set_bottom(false)
		open_door(true)

func set_bottom(b):
	bottom_collision.set_deferred("disabled", b)

func open_door(b):
	var t : Tween = create_tween()
	if(b):
		t.tween_property(door, "position:y", 500, .2)
	else:
		t.tween_property(door, "position:y", 0, .2)

func on_load():
	loaded = true

func _on_door_closer_activated() -> void:
	open_door(false)
	await get_tree().create_timer(1).timeout
	if(global_position.y > 0):
		move_up(10)
	else:
		move_down(10)

func move_down(time=1.0):
	move(152, time)

func move_up(time=1.0):
	move(-1176, time)

func move(dest, time=1.0):
	var t : Tween = create_tween()
	t.tween_property(self, "global_position:y", dest, time)
	t.finished.connect(finish_moving)

func finish_moving():
	finished_moving.emit()
	
