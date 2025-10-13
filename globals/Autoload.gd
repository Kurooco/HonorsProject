extends Node

var player = null
var level_handler = null

func set_player_disabled(e: bool):
	if(is_instance_valid(player)):
		player.disabled = e
