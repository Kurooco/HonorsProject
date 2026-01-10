extends Sprite2D

func _ready():
	$AudioStreamPlayer2D.seek(randf_range(0, 2.0))

func _process(delta):
	rotation += delta*2
	$Sprite2D.rotation -= delta*4
	
