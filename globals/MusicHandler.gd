extends Node

var current_song_path = ""
var current_song_node : AudioStreamPlayer = null
var play_music = false
var single_polyphony_sounds : Dictionary[String, AudioStreamPlayer2D]

func play(music:AudioStream, db=0.0, pitch=1.0):
	var path = music.resource_path
	if(!play_music):
		print_debug("WARNING: Music turned off!!!")
	if(path != current_song_path && play_music):
		current_song_path = path
		if(is_instance_valid(current_song_node)):
			current_song_node.queue_free()
		current_song_node = AudioStreamPlayer.new()
		current_song_node.volume_db = db
		current_song_node.pitch_scale = pitch
		current_song_node.bus = "Music"
		current_song_node.stream = music
		get_tree().current_scene.add_child.call_deferred(current_song_node)
		current_song_node.tree_entered.connect(current_song_node.play)

func stop():
	current_song_node.queue_free()
	current_song_path = ""

func play_single_polyphony_sound(pos:Vector2, path:String):
	if(!single_polyphony_sounds.has(path)):
		single_polyphony_sounds[path] = AudioStreamPlayer2D.new()
		single_polyphony_sounds[path].stream = load(path)
		get_tree().current_scene.add_child(single_polyphony_sounds[path])
	single_polyphony_sounds[path].position = pos
	single_polyphony_sounds[path].play()
