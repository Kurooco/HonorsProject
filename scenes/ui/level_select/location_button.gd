extends Button

@export var level : String
@export var level_name : String

signal selected

func _ready():
	$Name.text = level_name

func _on_pressed():
	selected.emit()
	Autoload.level_handler.switch_level(level)
