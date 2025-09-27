extends Sprite2D

var direction = 0
var speed = 600


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += speed*delta*direction
	rotation += 5*delta


func _on_weapon_area_attacked():
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
