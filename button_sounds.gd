extends AudioStreamPlayer

@export var collection : ButtonSoundCollection

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if(get_parent() is Button):
		var parent : Button = get_parent()
		parent.pressed.connect(play_sound.bind(collection.click))
		parent.mouse_entered.connect(play_sound.bind(collection.hover))

func play_sound(sound:AudioStream):
	stream = sound
	play()
