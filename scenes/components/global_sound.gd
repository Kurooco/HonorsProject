extends Node2D

@export var sound : AudioStream

func play():
	var player = AudioStreamPlayer2D.new()
	player.global_position = global_position
	player.stream = sound
	player.finished.connect(player.queue_free)
	Autoload.level_handler.current_level.add_child(player)
	player.play()
