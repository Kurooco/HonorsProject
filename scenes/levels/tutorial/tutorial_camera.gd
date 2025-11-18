extends Camera2D

@export var player : CharacterBody2D
var zoom_tween : Tween
var is_focused_on_player = false

func _ready():
	position = Vector2.ZERO
	zoom = Vector2(2, 2)

func focus_on_player(z = 1.0):
	is_focused_on_player = true
	set_zoom_smooth(z)

func _process(delta):
	if(is_focused_on_player):
		position = player.position

func focus_on_point(p: Vector2, z = 1.0):
	is_focused_on_player = false
	position = p
	set_zoom_smooth(z)

func set_zoom_smooth(z = 1.0):
	if(is_instance_valid(zoom_tween)):
		zoom_tween.kill()
	zoom_tween = get_tree().create_tween()
	zoom_tween.tween_property(self, "zoom", Vector2(z, z), 1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
