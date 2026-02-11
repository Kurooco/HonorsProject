extends "res://scenes/components/interaction_area.gd"

@export var set_as_claimed = false

var bird_killed = false
var default_scale

func _process(delta):
	if(!bird_killed):
		var change = sin(Time.get_ticks_msec()/200.0)/5.0
		$Bird.skew = change
		$Bird.scale.y = default_scale.y + abs(change)/2.0
	else:
		$Bird.position.y += delta*400
		$Bird.rotation += delta*10
	

func _ready():
	default_scale = $Bird.scale
	if(set_as_claimed):
		claim(false)

func _on_activated():
	claim(true)
	
func claim(effects:bool=true, actual=true):
	if(actual && Autoload.level_handler.check_point != position):
		Autoload.level_handler.claim_checkpoint(position)
		PlayerStats.level_points = PlayerStats.run_points
	if(effects):
		bird_killed = true
		$AudioStreamPlayer2D.play()
		$Label.modulate = Color.TRANSPARENT
		$Label.show()
		var t : Tween = create_tween()
		t.set_trans(Tween.TRANS_SINE)
		t.tween_property($Label, "position", $Label.position+Vector2(0, -50), .5)
		t.parallel().tween_property($Label, "modulate", Color.WHITE, .5)
		await t.finished
		await get_tree().create_timer(1).timeout
		t = create_tween()
		t.set_trans(Tween.TRANS_SINE)
		t.tween_property($Label, "position", $Label.position+Vector2(0, 50), .5)
		t.parallel().tween_property($Label, "modulate", Color.TRANSPARENT, .5)
	else:
		$Bird.hide()
		disabled = true
