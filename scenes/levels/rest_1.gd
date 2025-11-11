extends Node2D

@export var textured_collision_groups : Dictionary[Node2D, Texture]

# Called when the node enters the scene tree for the first time.
func _ready():
	for node in textured_collision_groups.keys():
		for child in node.get_children():
			if child is StaticBody2D:
				var col = child.get_children()[0]
				var shape = Polygon2D.new()
				shape.polygon = col.polygon
				var t : Texture = textured_collision_groups[node]
				shape.texture_repeat = CanvasItem.TEXTURE_REPEAT_ENABLED
				shape.texture = t
				shape.position = col.position
				child.add_child(shape)
	#$StaticBody2D/Polygon2D.polygon = $StaticBody2D/CollisionPolygon2D.polygon
