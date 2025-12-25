@tool
extends Button

@export var level : String
@export var level_name : String :
	set(ln):
		level_name = ln
		$Name.text = level_name
var locked = false
var locked_icon = preload("res://art/ui/x.png")

signal selected

func _ready():
	$Name.text = level_name
		

func _on_pressed():
	selected.emit()
	Autoload.level_handler.switch_level(level)

func lock():
	locked = true
	$Name.text = "LOCKED"
	icon = locked_icon
	disabled = true
