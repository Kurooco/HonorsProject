extends Node

var total_points = 0
var level_points = 0
var run_points = 0
var player = null
var level_handler = null

func set_player_disabled(e: bool):
	player.disabled = e
