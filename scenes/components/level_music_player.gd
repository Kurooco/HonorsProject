extends Node

@export var path : String
@export var db = 0.0
@export var mute = false
@export var pitch = 1.0

func _ready():
	if(!mute):
		MusicHandler.play(path, db, pitch)
