extends TileMapLayer

@onready var player: CharacterBody2D = $"../Player"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for cell in get_used_cells():
		var tile_data : TileData = get_cell_tile_data(cell)
		var tile_size = tile_set.tile_size.x
		if(tile_data.get_custom_data("enemy")):
			var new_enemy = load("res://experimentation/pipes_mini_game/enemy_variation_2.tscn").instantiate()
			new_enemy.global_position = Vector2(cell*tile_size) + Vector2(tile_size/2, tile_size/2)
			new_enemy.current_cell = cell
			new_enemy.player = player
			add_child(new_enemy)
			set_cell(cell, 1, Vector2i.ZERO)
