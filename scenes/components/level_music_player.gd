extends Node

@export var path : String
@export var db = 0.0
@export var mute = false

func _ready():
	if(!mute):
		MusicHandler.play(path, db)
