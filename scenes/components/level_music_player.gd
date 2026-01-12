extends Node

@export var path : String
@export var db = 0.0

func _ready():
	MusicHandler.play(path, db)
