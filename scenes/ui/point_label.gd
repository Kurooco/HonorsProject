extends Label

var label_height = -30

func _ready():
	var label_tween = create_tween()
	label_tween.tween_property(self, "global_position", global_position+Vector2(0, label_height), .5).set_trans(Tween.TRANS_CUBIC)
	label_tween.parallel().tween_property(self, "modulate", Color.WHITE, .5).set_trans(Tween.TRANS_CUBIC)
	label_tween.tween_property(self, "global_position", global_position, .5).set_delay(1).set_trans(Tween.TRANS_CUBIC)
	label_tween.parallel().tween_property(self, "modulate", Color.TRANSPARENT, .5).set_delay(1).set_trans(Tween.TRANS_CUBIC)
	label_tween.tween_callback(self.queue_free)
