extends Node2D


func _on_visible_on_screen_notifier_2d_screen_exited():
	print_debug("gone")
	queue_free()
