extends Area2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var player : CharacterBody2D
@export var map : TileMapLayer
var current_cell : Vector2i
var visited_cells = {}
var move_tween : Tween
var pursuit_radius = 16

func _ready() -> void:
	if(get_parent() is TileMapLayer):
		map = get_parent()
	#global_position = (global_position-map.global_position) - (global_position-map.global_position)%tile_size
	#print_debug(current_cell)

func start():
	$Timer.start()

func stop():
	$Timer.stop()

func is_wall(cell:Vector2i):
	var enemies = get_tree().get_nodes_in_group("maze_enemy")
	for e in enemies:
		if(e != self && e.current_cell == cell):
			return true
	var tile_data : TileData = map.get_cell_tile_data(cell)
	return tile_data.get_custom_data("wall")

func _on_timer_timeout() -> void:
	var path = get_path_to_player()
	if(path.size() >= 2):
		var next_move = get_path_to_player()[1]
		current_cell = next_move
		update_position(current_cell)
		#print_debug(current_cell)

func update_position(cell):
	move_tween = create_tween()
	move_tween.tween_property(self, "global_position", get_cell_global_position(cell), $Timer.wait_time).set_trans(Tween.TRANS_EXPO)
	# - Vector2(tile_size/2, tile_size/2)
	#print_debug(global_position)

func get_path_to_player():
	var cell_queue = []
	visited_cells.clear()
	visited_cells.set(current_cell, [])
	cell_queue.append(current_cell)
	
	var min_dist = INF
	var min_path = []
	while(!cell_queue.is_empty()):
		var cell = cell_queue.pop_front()
		var dist = player.global_position.distance_to(get_cell_global_position(cell))
		if(dist < pursuit_radius):
			visited_cells[cell].append(cell)
			return visited_cells[cell]
		elif(dist < min_dist):
			min_dist = dist
			min_path = visited_cells[cell]
		
		# Find adjacent
		for x in range(-1, 2):
			for y in range(-1, 2):
				if(x != y && (x == 0 || y == 0)):
					var new = cell + Vector2i(x, y)
					if(!is_wall(cell) && new not in visited_cells):
						cell_queue.append(new)
						var new_path = visited_cells[cell].duplicate()
						new_path.append(cell)
						visited_cells.set(new, new_path)
	return min_path
		
func get_cell_global_position(cell:Vector2i):
	return map.to_global(map.map_to_local(cell))
