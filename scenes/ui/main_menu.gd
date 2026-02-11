extends CanvasLayer

@onready var camera_2d: Camera2D = $SubViewportContainer/SubViewport/Camera2D
var speed = 300

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Autoload.level_handler.pause_disabled = true
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
