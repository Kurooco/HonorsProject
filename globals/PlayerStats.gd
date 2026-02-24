extends Node

var jumps = 0
var acorns = 0
var lives = 0
var levels_unlocked = 0
var saved_level_path : String = ""
var saved_level_position : Vector2

var total_points = 0
var level_points = 0
var run_points = 1500

signal stat_updated


func update_player_stats():
	Autoload.player.update_stats()


func sync_points():
	level_points = run_points
	total_points = run_points


func revert_points():
	run_points = total_points
	level_points = total_points


func add_points_permanent(amount: int):
	run_points += amount
	level_points = run_points
	total_points = run_points
