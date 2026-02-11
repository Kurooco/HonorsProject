extends CanvasLayer

@onready var continue_button: Button = $ButtonContainer/Continue
@onready var camera_2d: Camera2D = $Background/SubViewport/Camera2D
var speed = 500

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Autoload.level_handler.pause_disabled = true
	if(PlayerStats.saved_level_path != ""):
		continue_button.show()
	var t : Tween = create_tween()
	t.set_trans(Tween.TRANS_QUINT)
	t.set_ease(Tween.EASE_OUT)
	t.tween_property(camera_2d, "position:y", 0, 4)
	t.parallel().tween_property($Title, "position:y", 0, 3).from(-500)
	t.parallel().tween_property(self, "speed", 50, 4)
	t.parallel().tween_property($CheckPoint, "position:y", 476, 4).from(1000)
	t.parallel().tween_property($ButtonContainer, "position:y", 448, 4).from(1000)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	camera_2d.position.x += delta*speed


func _on_secret_button_pressed() -> void:
	$CheckPoint.claim(true, false)


func _on_new_game_pressed() -> void:
	$NicePiano.play()
	MusicHandler.fade_out(4)
	Autoload.level_handler.fade_out(Color.BLACK, 4)
	await Autoload.level_handler.fade_ended
	Autoload.level_handler.new_game()
	Autoload.level_handler.fade_in(2)


func _on_continue_pressed() -> void:
	Autoload.level_handler.set_level(PlayerStats.saved_level_path, true, PlayerStats.saved_level_position)
