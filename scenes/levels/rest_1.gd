extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is StaticBody2D:
			var col = child.get_children()[0]
			var shape = Polygon2D.new()
			shape.polygon = col.polygon
			#shape.color = Color.SADDLE_BROWN
			var t : Texture = load("res://art/wood.png")
			shape.texture_repeat = CanvasItem.TEXTURE_REPEAT_ENABLED
			shape.texture = t
			child.add_child(shape)
	#$StaticBody2D/Polygon2D.polygon = $StaticBody2D/CollisionPolygon2D.polygon


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
