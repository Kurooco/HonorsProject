extends Node

@export var opening_scene : PackedScene
@export var rest_levels : Array[PackedScene]
@export var level_order : Array[PackedScene]
@onready var fade = $FadeCanvas/Fade
@onready var upgrade_menu = $UpgradeMenu
@onready var game_saver = $GameSaver

var current_level : Node = null
var fade_tween : Tween = null
var check_point = Vector2.ZERO
var in_rest_level = false
var level_number = -1
var last_rest_level_visited : PackedScene = null

signal fade_ended
signal data_loaded

# Called when the node enters the scene tree for the first time.
func _ready():
	Autoload.level_handler = self
	set_level("res://scenes/ui/recording_question.tscn")
	
func begin():
	game_saver.clear_temp()
	game_saver.load_game(0)
	set_level(opening_scene.resource_path)
	Dialogic.signal_event.connect(handle_dialogic_signals)

func set_level(path: String):
	if(is_instance_valid(current_level)):
		if(Autoload.level_handler.in_rest_level):
			game_saver.save_level()
		remove_child(current_level)
		current_level.queue_free()
	var packed_level = load(path)
	if(packed_level in rest_levels):
		last_rest_level_visited = packed_level
		if(level_order.find(packed_level) >= PlayerStats.levels_unlocked):
			PlayerStats.levels_unlocked = level_order.find(packed_level)+2
	var new_level = packed_level.instantiate()
	set_level_number(packed_level)
	current_level = new_level
	game_saver.world_scene = new_level
	if(packed_level in rest_levels):
		game_saver.load_level()
		in_rest_level = true
	else:
		in_rest_level = false
	var player = get_node_in_group(current_level, "player")
	if(is_instance_valid(player)):
		check_point = player.position
	add_child(new_level)
	

func restart_level():
	if(Autoload.level_handler.in_rest_level):
		game_saver.save_level()
	fade_out()
	await fade_ended
	await get_tree().create_timer(1).timeout
	if(is_instance_valid(current_level)):
		remove_child(current_level)
		current_level.queue_free()
	var new_level = load(current_level.scene_file_path).instantiate()
	set_level_number(load(current_level.scene_file_path))
	current_level = new_level
	game_saver.world_scene = new_level
	game_saver.load_level()
	
	var player = get_node_in_group(current_level, "player")
	var camera = get_node_in_group(current_level, "level_camera")
	player.position = check_point
	camera.position.x = max(check_point.x, camera.position.x)
	for i in get_nodes_in_group(current_level, "checkpoint"):
		if(i.position == check_point):
			i.claim()
	PlayerStats.run_points = PlayerStats.level_points
	add_child(new_level)
	
	fade_in()

func fade_out(color=Color.BLACK):
	fade.show()
	if(is_instance_valid(fade_tween)):
		fade_tween.kill()
	fade_tween = create_tween()
	fade_tween.tween_property(fade, "color", color, 1)
	fade_tween.tween_callback(fade_ended.emit)

func fade_in():
	var transparent_color = Color(fade.color.r, fade.color.g, fade.color.b, 0)
	if(is_instance_valid(fade_tween)):
		fade_tween.kill()
	fade_tween = create_tween()
	fade_tween.tween_property(fade, "color", transparent_color, 1)
	fade_tween.tween_callback(fade_ended.emit)
	fade_tween.tween_callback(fade.hide)

func get_node_in_group(node, group) -> Node:
	var children : Array = node.get_children().duplicate()
	for child in children:
		if(child.is_in_group(group)):
			return child
		var group_child = get_node_in_group(child, group)
		if(group_child != null):
			return group_child
	return null

func get_nodes_in_group(node, group) -> Array[Node]:
	var children : Array = node.get_children().duplicate()
	var group_children : Array[Node] = []
	for child in children:
		if(child.is_in_group(group)):
			group_children.append(child)
		group_children.append_array(get_nodes_in_group(child, group))
	return group_children

func handle_dialogic_signals(name):
	match name:
		"upgrade_menu":
			upgrade_menu.visible = !upgrade_menu.visible
		"fade":
			fade_out()
			await fade_ended
			await get_tree().create_timer(1).timeout
			fade_in()

func claim_checkpoint(p: Vector2):
	check_point = p
	
func switch_level(level: String):
	fade_out()
	await fade_ended
	$LevelWinScreen.hide()
	set_level(level)
	fade_in()

func end_level(level:String):
	Autoload.player.make_invincible()
	$LevelWinScreen.show()
	await get_tree().create_timer(2).timeout
	switch_level(level)

func show_save_menu():
	var menu = load("res://scenes/ui/save_menu/save_menu.tscn").instantiate()
	add_child(menu)

func set_level_number(scene: PackedScene):
	level_number = level_order.find(scene)
	
func pause_game(pause: bool):
	set_pause_subtree(current_level, pause)

# Credit needed: found this on a reddit form
func set_pause_subtree(root: Node, pause: bool) -> void:
	var process_setters = ["set_process",
	"set_physics_process",
	"set_process_input",
	"set_process_unhandled_input",
	"set_process_unhandled_key_input",
	"set_process_shortcut_input"]
	
	for setter in process_setters:
		root.propagate_call(setter, [!pause])
	root.propagate_call("set", ["paused", pause])
	
	if(pause):
		root.propagate_call("set", ["mouse_filter", Control.MOUSE_FILTER_IGNORE])
	else:
		root.propagate_call("set", ["mouse_filter", Control.MOUSE_FILTER_PASS])
