extends Sprite2D



func _process(delta):
	rotation += delta*2
	$Sprite2D.rotation -= delta*4
