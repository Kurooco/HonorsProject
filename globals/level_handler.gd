extends Node

@export var opening_scene : PackedScene
@onready var fade = $FadeCanvas/Fade
var current_level : Node = null
var fade_tween : Tween = null

signal fade_ended

# Called when the node enters the scene tree for the first time.
func _ready():
	Autoload.level_handler = self
	set_level(opening_scene.resource_path)


func set_level(path: String):
	if(is_instance_valid(current_level)):
		remove_child(current_level)
		current_level.queue_free()
	var new_level = load(path).instantiate()
	current_level = new_level
	add_child(new_level)


func restart_level():
	fade_out()
	await fade_ended
	await get_tree().create_timer(1).timeout
	set_level(current_level.scene_file_path)
	fade_in()
	await fade_ended

func fade_out(color=Color.BLACK):
	if(is_instance_valid(fade_tween)):
		fade_tween.kill()
	fade_tween = create_tween()
	fade_tween.tween_property(fade, "color", color, 1)
	fade_tween.tween_callback(fade_ended.emit)
	
func fade_in():
	var transparent_color = Color(fade.color.r, fade.color.g, fade.color.b, 0)
	if(is_instance_valid(fade_tween)):
		fade_tween.kill()
	fade_tween = create_tween()
	fade_tween.tween_property(fade, "color", transparent_color, 1)
	fade_tween.tween_callback(fade_ended.emit)
