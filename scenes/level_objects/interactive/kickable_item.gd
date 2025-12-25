extends RigidBody2D

@export var area : Area2D
@export var coin_amount = 5
@export var shatter_vel = 300
var saved_node_references = ["area"]
var loaded = false

func _ready():
	if(is_in_group("saveable")):
		save_children(self)
	area.collision_mask = 5
	area.collision_layer = 0
	area.body_entered.connect(_on_area_2d_body_entered)

func _on_area_2d_body_entered(body):
	print(body.name)
	if(body.is_in_group("player")):
		var dir = -1 if body.position.x > position.x else 1
		apply_impulse(Vector2(randi_range(100, 300)*dir, -400))
	elif(linear_velocity.length() > shatter_vel):
		shatter()

func shatter():
	for i in range(coin_amount):
		var coin = load("res://scenes/components/dropped_item.tscn").instantiate()
		coin.scene = load("res://scenes/level_objects/assist/coin.tscn")
		coin.global_position = global_position
		coin.remove_from_group("saveable")
		Autoload.level_handler.current_level.call_deferred("add_child", coin)
	queue_free()

func save_children(node):
	for child in node.get_children(true):
		child.add_to_group("saveable")
		save_children(child)
