extends Node

@export var string : String
@export var dictionary : Dictionary

signal matched
signal matched_string
signal matched_dict(value)
signal matched_key(key, value)

func _ready():
	Dialogic.signal_event.connect(check_signal)
	
func check_signal(arg):
	if((arg is String && arg == string)):
		matched.emit()
		matched_string.emit()
	elif(arg is Dictionary):
		for key in dictionary:
			if(key in arg.keys()):
				matched_key.emit(key, arg[key])
				if(arg[key] == dictionary[key]):
					matched.emit()
					matched_dict.emit(dictionary["key"])
	
