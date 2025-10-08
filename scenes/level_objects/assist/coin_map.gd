extends TileMapLayer

@export var world_node : Node

# Called when the node enters the scene tree for the first time.
func _ready():
	var tile_size = tile_set.tile_size;
	for place in get_used_cells():
		var path = get_cell_tile_data(place).get_custom_data("scene_path")
		var origin = get_cell_tile_data(place).texture_origin
		if(path != ""):
			var new_coin = load(path).instantiate()
			new_coin.position = place*tile_size.x + tile_size/2 - origin
			world_node.add_child.call_deferred(new_coin)
	clear()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
