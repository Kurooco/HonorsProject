extends Node

var jumps = 0
var acorns = 0
var lives = 0
var levels_unlocked = 1
var saved_level_path : String = ""

var total_points = 0
var level_points = 0
var run_points = 0

signal stat_updated

func update_player_stats():
	Autoload.player.update_stats()


func sync_points():
	level_points = run_points
	total_points = run_points


func add_points_permanent(amount: int):
	run_points += amount
	level_points = run_points
	total_points = run_points
