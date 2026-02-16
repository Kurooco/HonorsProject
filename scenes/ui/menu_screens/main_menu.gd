extends CanvasLayer

@onready var continue_button: Button = $ButtonContainer/Continue
@onready var camera_2d: Camera2D = $Background/SubViewport/Camera2D
@onready var new_game_warning: Button = $ButtonContainer/NewGameWarning
@onready var new_game: Button = $ButtonContainer/NewGame
var speed = 500

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var save_data = Autoload.level_handler.has_saved_game()
	continue_button.visible = save_data
	new_game.visible = !save_data
	new_game_warning.visible = save_data
	
	Autoload.level_handler.pause_disabled = true
	var t : Tween = create_tween()
	t.set_trans(Tween.TRANS_QUINT)
	t.set_ease(Tween.EASE_OUT)
	t.tween_property(camera_2d, "position:y", 0, 4)
	t.parallel().tween_property($Title, "position:y", 0, 3).from(-500)
	t.parallel().tween_property(self, "speed", 50, 4)
	t.parallel().tween_property($CheckPoint, "position:y", 476, 4).from(1000)
	t.parallel().tween_property($ButtonContainer, "position:y", $ButtonContainer.position.y, 4).from(1000)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	camera_2d.position.x += delta*speed


func _on_secret_button_pressed() -> void:
	$CheckPoint.claim(true, false)


func _on_new_game_pressed() -> void:
	Autoload.level_handler.new_game()


func _on_continue_pressed() -> void:
	Autoload.level_handler.continue_game()
