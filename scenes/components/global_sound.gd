extends Node2D

@export var sound : AudioStream
@export var vol = 0.0

func play():
	var player = AudioStreamPlayer2D.new()
	player.volume_db = vol
	player.bus = "Sound"
	player.global_position = global_position
	player.stream = sound
	player.finished.connect(player.queue_free)
	Autoload.level_handler.current_level.add_child(player)
	player.play()
