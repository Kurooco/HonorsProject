extends Node
class_name HealthComponent

@export var max_health = 100
var health

signal killed

# Called when the node enters the scene tree for the first time.
func _ready():
	health = max_health

func hurt(amount: int):
	if(health-amount <= 0 && health > 0):
		killed.emit()
	health = max(0, health-amount)

func revive(amount: int):
	health = min(max_health, health+amount)
	
func full_revive():
	health = max_health
