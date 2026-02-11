extends Node

@export var music : AudioStream
@export var db = 0.0
@export var mute = false
@export var pitch = 1.0

func _ready():
	if(!mute):
		MusicHandler.play(music, db, pitch)
