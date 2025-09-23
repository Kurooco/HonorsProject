extends Area2D
class_name Food


func jump_on():
	$ArcMover.velocity.y = 700
	set_deferred("monitorable", false)
