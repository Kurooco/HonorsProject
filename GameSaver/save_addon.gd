extends Node

@export var attributes : Array[String]
@export var class_of_object : String

var ignore_properties = ["owner"]

# Called when the node enters the scene tree for the first time.
func _ready():
	#print(type_string(typeof(self)))
	if(class_of_object == ""):
		push_warning(name+"'s object type is empty!")
		class_of_object = get_class()
	#if(!is_instance_valid(class_of_object)):
	#	class_of_object = get_class()
	#pass

"""func save():
	if(attributes.is_empty()):
		var property_list = get_property_list()
		var property_names = []
		for i in property_list:
			if(not i["name"] in ignore_properties):
				property_names.append(i["name"])
		return property_names
	return attributes.duplicate()"""
