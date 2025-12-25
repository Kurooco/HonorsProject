extends StaticBody2D

@export var key_table = false
var broken = false
signal broke


func _on_interaction_area_entered():
	if(Input.is_action_pressed("dive") && !broken):
		collision_layer = 0
		$Sprite2D.texture = load("res://art/environment/interactive/broken_table.png")
		broke.emit()
		if(key_table):
			Dialogic.VAR.set_variable("table_broken", true)
