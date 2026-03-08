extends Sprite2D

#var class_of_object = "Sprite2D"
@onready var bottom_collision: CollisionShape2D = $Bottom/BottomCollision
@onready var door: StaticBody2D = $Door

func set_bottom(b):
	bottom_collision.set_deferred("disabled", b)

func open_door(b):
	var t : Tween = create_tween()
	if(b):
		t.tween_property(door, "position:y", 500, .2)
	else:
		t.tween_property(door, "position:y", 0, .2)
