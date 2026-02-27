extends Camera2D

@export var player : Node
@export var x_bounds : Vector2
@export var y_bounds : Vector2
var current_position : Vector2
var standard_zoom : Vector2
var origin_point : Vector2
var move_tween : Tween
var screen_width : float
var screen_height : float
var out_of_bounds = false

var focused = false
var focused_on_player = false

signal position_updated

# Called when the node enters the scene tree for the first time.
func _ready():
	current_position = position
	origin_point = current_position
	screen_width = get_viewport_rect().size.x/zoom.x
	screen_height = get_viewport_rect().size.y/zoom.y	
	standard_zoom = zoom

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(!is_instance_valid(player)): return
	
	if(focused_on_player):
		position = player.position
	elif(!focused):
		var x_screen = round(player.position.x/screen_width) 
		var y_screen = round(player.position.y/screen_height)
		if(abs(player.position.x - current_position.x) > screen_width/2 && x_screen >= x_bounds.x && x_screen <= x_bounds.y):
			current_position.x = x_screen * screen_width
			update_position()
		if(abs(player.position.y - current_position.y) > screen_height/2 && y_screen >= y_bounds.x && y_screen <= y_bounds.y):
			current_position.y = y_screen * screen_height
			update_position()
	
		#Out of bounds
		if(y_screen > y_bounds.y && !out_of_bounds):
			Autoload.level_handler.restart_level()
			out_of_bounds = true
		
func update_position():
	if(is_instance_valid(move_tween)):
		move_tween.kill()
	move_tween = create_tween()
	move_tween.tween_property(self, "position", current_position, .5).set_trans(Tween.TRANS_CIRC)
	move_tween.parallel().tween_property(self, "zoom", standard_zoom, .5).set_trans(Tween.TRANS_CIRC)
	move_tween.finished.connect(revert_focus)

func focus(pos:Vector2, z=Vector2(2, 2)):
	focused = true
	focused_on_player = false
	move_tween = create_tween()
	move_tween.tween_property(self, "position", pos, 2).set_trans(Tween.TRANS_QUAD)
	move_tween.parallel().tween_property(self, "zoom", z, 2).set_trans(Tween.TRANS_QUAD)

func focus_on_player(z=Vector2(1, 1)):
	focused = true
	focused_on_player = true
	move_tween = create_tween()
	move_tween.tween_property(self, "zoom", z, 2).set_trans(Tween.TRANS_QUAD)

func defocus():
	update_position()

func revert_focus():
	focused = false
	focused_on_player = false
