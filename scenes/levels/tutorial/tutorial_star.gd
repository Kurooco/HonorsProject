@tool
extends InteractionArea

@export_tool_button("Add Current Position") var add = add_current_position
@export var positions : Array[Vector2]
var ind = 0

signal captured(ind)

# Called when the node enters the scene tree for the first time.
func _ready():
	if(!positions.is_empty()):
		position = positions[0]
	


func capture():
	ind += 1
	captured.emit(ind)
	$AudioStreamPlayer2D.play()
	
	disabled = true
	var fade_tween = create_tween()
	fade_tween.tween_property(self, "modulate", Color.TRANSPARENT, 1)
	await fade_tween.finished
	
	if(ind >= positions.size()):
		queue_free()
		return
	position = positions[ind]
	
	await get_tree().create_timer(1).timeout
	fade_tween = create_tween()
	fade_tween.tween_property(self, "modulate", Color.WHITE, .3)
	await fade_tween.finished
	disabled = false

func add_current_position():
	positions.append(position)
