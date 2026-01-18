extends Sprite2D

@export var pitch_range : Vector2

func _ready():
	$AudioStreamPlayer2D.pitch_scale = randf_range(pitch_range.x, pitch_range.y)

func _process(delta):
	rotation += delta*2
	$Sprite2D.rotation -= delta*4
	
