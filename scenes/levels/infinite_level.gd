extends Node2D

@export var speed = 100
@export var pieces : Array[PackedScene]
@onready var player = $Roller/Player

var placed_position = 576

func _ready():
	seed(0)
	place_piece(placed_position)
	placed_position += get_viewport_rect().size.x
	set_process(false)
	await player.started
	set_process(true)
	
func _process(delta):
	$Roller.position.x -= delta*speed
	var pos = (-$Roller.position.x)+get_viewport_rect().size.x
	#print_debug(str(placed_position)+", "+str(pos))
	if(placed_position < pos):
		place_piece(placed_position)
		placed_position += get_viewport_rect().size.x

func place_piece(place):
	#print_debug("new piece added at "+str(place))
	var piece = pieces[randi_range(0, pieces.size()-1)].instantiate()
	$Roller.add_child(piece)
	piece.position = Vector2(place, 0)
	
	
