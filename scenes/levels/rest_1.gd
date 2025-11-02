extends Node2D

@export var texture : Texture

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in $LevelCollision.get_children():
		if child is StaticBody2D:
			var col = child.get_children()[0]
			var shape = Polygon2D.new()
			shape.polygon = col.polygon
			var t : Texture = texture
			shape.texture_repeat = CanvasItem.TEXTURE_REPEAT_ENABLED
			shape.texture = t
			shape.global_position = col.global_position
			child.add_child(shape)
	#$StaticBody2D/Polygon2D.polygon = $StaticBody2D/CollisionPolygon2D.polygon
