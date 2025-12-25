extends Node

@export var string : String
@export var dictionary : Dictionary

signal matched
signal matched_string
signal matched_dict(value)

func _ready():
	Dialogic.signal_event.connect(check_signal)
	
func check_signal(arg):
	if((arg is String && arg == string)):
		matched.emit()
		matched_string.emit()
	else:
		for key in dictionary:
			if(arg.has(key) && arg["key"] == dictionary["key"]):
				matched.emit()
				matched_dict.emit(dictionary["key"])
	
