extends Path2D

@export var foliage : PackedScene
@export var size_variation = Vector2(1, 1)
@export var spacing = 20

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var follower = PathFollow2D.new()
	follower.rotates = true
	follower.loop = false
	add_child(follower)
	while follower.progress_ratio < 1.0:
		follower.progress += spacing
		create_plant(follower)

func create_plant(follower:PathFollow2D):
	var new_plant = foliage.instantiate()
	new_plant.global_position = follower.global_position
	new_plant.rotation = follower.rotation
	var sc = randf_range(size_variation.x, size_variation.y)
	new_plant.scale = Vector2(sc, sc)
	new_plant.z_index = z_index
	Autoload.level_handler.current_level.call_deferred("add_child", new_plant)
