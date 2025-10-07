extends Camera2D

@export var player : Node
@export var x_bounds : Vector2
@export var y_bounds : Vector2
var current_position : Vector2
var origin_point : Vector2
var move_tween : Tween
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
	var x_screen = round(player.position.x/screen_width) 
	var y_screen = round(player.position.y/screen_height)
	if(abs(player.position.x - current_position.x) > screen_width/2 && x_screen > x_bounds.x && x_screen < x_bounds.y):
		current_position.x = x_screen * screen_width
		update_position()
	if(abs(player.position.y - current_position.y) > screen_height/2 && y_screen > y_bounds.x && y_screen < y_bounds.y):
		current_position.y = y_screen * screen_height
		update_position()

func update_position():
	if(is_instance_valid(move_tween)):
		move_tween.kill()
	move_tween = create_tween()
	move_tween.tween_property(self, "position", current_position, .1).set_trans(Tween.TRANS_QUART)
