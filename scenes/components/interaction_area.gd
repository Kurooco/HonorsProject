extends Area2D
class_name InteractionArea

## If true, automatically fires the activated signal when area is entered
@export var automatic = false
## If true, will show a prompt above the player's head asking them to press
## the interaction button
@export var show_prompt = true
@export var one_shot = false
var is_inside = false
var activated_since_entering = false

signal activated
signal entered
signal exited

func enter():
	is_inside = true
	entered.emit()
	if(automatic && (!activated_since_entering || !one_shot)):
		activate()

func exit():
	if(!activated_since_entering || !one_shot):
		activated_since_entering = false
	is_inside = false
	exited.emit()

func activate():
	if(!activated_since_entering || !one_shot):
		activated_since_entering = true
		activated.emit()
