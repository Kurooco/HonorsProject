extends Camera2D

@export var player : Node
var current_position : Vector2
var origin_point : Vector2
var x_move_tween : Tween
var y_move_tween : Tween
var screen_width : float
var screen_height : float

# Called when the node enters the scene tree for the first time.
func _ready():
	current_position = position
	origin_point = current_position
	screen_width = get_viewport_rect().size.x/zoom.x
	screen_height = get_viewport_rect().size.y/zoom.y	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(abs(player.position.x - current_position.x) > screen_width/2):
		current_position.x = round(player.position.x/screen_width) * screen_width
		update_position()
	if(abs(player.position.y - current_position.y) > screen_height/2):
		current_position.y = round(player.position.y/screen_height) * screen_height
		update_position()

func update_position():
	if(is_instance_valid(x_move_tween)):
		x_move_tween.kill()
	x_move_tween = create_tween()
	x_move_tween.tween_property(self, "position", current_position, .1).set_trans(Tween.TRANS_QUART)
