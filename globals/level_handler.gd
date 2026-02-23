extends Node

@export var opening_scene : PackedScene
@export var rest_levels : Array[PackedScene]
@export var level_order : Array[PackedScene]
@onready var fade = $FadeCanvas/Fade
@onready var upgrade_menu = $UpgradeMenu
@onready var game_saver = $GameSaver

var pause_disabled = true
var current_level : Node = null
var fade_tween : Tween = null
var check_point = Vector2.ZERO
var in_rest_level = false
var last_rest_level_visited : PackedScene = null

signal fade_ended
signal data_loaded

# Called when the node enters the scene tree for the first time.
func _ready():
	game_saver.clear_temp()
	Autoload.level_handler = self
	set_level(opening_scene.resource_path)
	Dialogic.signal_event.connect(handle_dialogic_signals)

func new_game():
	$NicePiano.play()
	MusicHandler.fade_out(4)
	Autoload.level_handler.fade_out(Color.BLACK, 4)
	await Autoload.level_handler.fade_ended
	game_saver.clear_all()
	data_loaded.emit()
	set_level("res://scenes/levels/tutorial/tutorial.tscn")
	Autoload.level_handler.fade_in(2)

func continue_game():
	game_saver.load_game(0)
	data_loaded.emit()
	set_level(PlayerStats.saved_level_path, true, PlayerStats.saved_level_position)

func create_new_level(path:String):
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
	current_level = new_level
	
	game_saver.world_scene = new_level
	if(packed_level in rest_levels):
		game_saver.load_level()
		in_rest_level = true
	else:
		in_rest_level = false
	
	return new_level

func set_level(path: String, fade=false, player_position:Vector2=Vector2.INF):
	pause_disabled = false
	
	if(fade):
		fade_out()
		await fade_ended
	
	var new_level = create_new_level(path)
	
	var player = get_node_in_group(current_level, "player")
	if(is_instance_valid(player)):
		check_point = player.position
		if(player_position != Vector2.INF):
			player.position = player_position
	add_child(new_level)
	
	if(fade):
		fade_in()

func set_level_with_spawn_point(path: String, spawn_point_name:String):
	pause_disabled = false
	
	if(fade):
		fade_out()
		await fade_ended
	
	create_new_level(path)
	
	# Find spawn point
	var spawn_points = get_nodes_in_group(current_level, "spawn_point")
	for s in spawn_points:
		if(s.point_name == spawn_point_name):
			var spawn_point_position = s.position
			print_debug(spawn_point_position)
			var player = get_node_in_group(current_level, "player")
			if(is_instance_valid(player)):
				check_point = player.position
				player.position = spawn_point_position
			break
	
	add_child(current_level)
	
	if(fade):
		fade_in()

func restart_level(override_position:Vector2 = Vector2.INF):
	if(Autoload.level_handler.in_rest_level):
		game_saver.save_level()
	fade_out()
	await fade_ended
	await get_tree().create_timer(1).timeout
	if(is_instance_valid(current_level)):
		remove_child(current_level)
		current_level.queue_free()
	var new_level = load(current_level.scene_file_path).instantiate()
	current_level = new_level
	game_saver.world_scene = new_level
	game_saver.load_level()
	
	var player = get_node_in_group(current_level, "player")
	var camera = get_node_in_group(current_level, "level_camera")
	
	if(override_position != Vector2.INF):
		player.position = override_position
	else:
		player.position = check_point
		
	if(is_instance_valid(camera)):
		camera.position.x = max(check_point.x, camera.position.x)
	for i in get_nodes_in_group(current_level, "checkpoint"):
		if(i.position == check_point):
			i.claim(false)
	PlayerStats.run_points = PlayerStats.level_points
	add_child(new_level)
	
	fade_in()

func fade_out(color=Color.BLACK, duration=1.0):
	fade.show()
	if(is_instance_valid(fade_tween)):
		fade_tween.kill()
	fade_tween = create_tween()
	fade_tween.tween_property(fade, "color", color, duration)
	fade_tween.tween_callback(fade_ended.emit)

func fade_in(duration=1.0):
	var transparent_color = Color(fade.color.r, fade.color.g, fade.color.b, 0)
	if(is_instance_valid(fade_tween)):
		fade_tween.kill()
	fade_tween = create_tween()
	fade_tween.tween_property(fade, "color", transparent_color, duration)
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


func _on_dialogic_signal_handler_matched_key(key: Variant, value: Variant) -> void:
	var p = load(value).instantiate()
	get_tree().current_scene.add_child(p)

func has_saved_game():
	return $GameSaver.get_save_metadata(0) != null
