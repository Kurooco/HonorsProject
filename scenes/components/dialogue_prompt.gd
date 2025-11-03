extends Node2D

@export var node : Node
@export var signal_name : Signal
@export var timeline : String

func _ready():
	signal_name.connect(Dialogic.start.bind(timeline))
