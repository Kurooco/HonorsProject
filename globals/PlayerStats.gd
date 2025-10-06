extends Node

var jumps = 0
var acorns = 0
var lives = 0

func update_player_stats():
	Autoload.player.update_stats()
