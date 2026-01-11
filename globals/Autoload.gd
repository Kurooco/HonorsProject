@tool
extends Node

signal player_changed(player)
var player = null
var level_handler = null
var group = 0

func set_player_disabled(e: bool):
	if(is_instance_valid(player)):
		player.disabled = e
