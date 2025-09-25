extends Area2D
class_name HurtBox

@export var health_component : Node
@export var friendly = false
@export var invincible_time = 2.0
var currently_invincible = false

signal became_vulnerable
signal hurt

func _ready():
	$InvinciblityTimer.wait_time = invincible_time
	

func damage(amount:int):
	if(!currently_invincible):
		hurt.emit()
		health_component.hurt(amount)
		currently_invincible = true
		$InvinciblityTimer.start()
	

func _on_invinciblity_timer_timeout():
	currently_invincible = false
	became_vulnerable.emit()
