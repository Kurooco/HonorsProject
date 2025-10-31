extends Collectable


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation += delta*2
	$Sprite2D2.rotation -= delta*6


func _on_collected():
	Autoload.player.acorn_energy = 100
	queue_free()
