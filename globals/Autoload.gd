@tool
extends Node

signal player_changed(player)
var player = null#: 
	#set(new_player):
	#	player_changed.emit(new_player)
var level_handler = null

func set_player_disabled(e: bool):
	if(is_instance_valid(player)):
		player.disabled = e
