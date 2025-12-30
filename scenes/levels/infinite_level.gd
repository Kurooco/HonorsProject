extends Node2D

@export var speed = 100
@onready var player = $Roller/Player

func _ready():
	set_process(false)
	await player.started
	set_process(true)
	
func _process(delta):
	$Roller.position.x -= delta*speed
