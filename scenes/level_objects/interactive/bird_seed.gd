extends Button

var bird_seed_progress = 0
var stages = ["res://art/environment/interactive/bird_seed1.png", 
"res://art/environment/interactive/bird_seed2.png", 
"res://art/environment/interactive/bird_seed3.png"]

func _on_pressed() -> void:
	bird_seed_progress += 1
	if(bird_seed_progress >= stages.size()):
		hide()
		$HappyTune.play()
	else:
		$TextureRect.texture = load(stages[bird_seed_progress])
