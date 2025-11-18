extends Label

@export var tutorial_star : Node
@export var ind = 0

var fade_tween : Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	modulate = Color.TRANSPARENT
	tutorial_star.captured.connect(check_for_appear)
	if(ind == 0):
		appear()

func check_for_appear(i):
	if(i == ind):
		appear()
	if(i > ind):
		disappear()
	

func appear():
	await get_tree().create_timer(1).timeout
	fade_tween = create_tween()
	fade_tween.tween_property(self, "modulate", Color.WHITE, 2)

func disappear():
	fade_tween = create_tween()
	fade_tween.tween_property(self, "modulate", Color.TRANSPARENT, 2)
