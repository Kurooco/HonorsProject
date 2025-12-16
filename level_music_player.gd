extends Node

@export var path : String

func _ready():
	MusicHandler.play(path)
