extends Node

var player = null
var level_handler = null
var in_rest_level = false

func set_player_disabled(e: bool):
	player.disabled = e
