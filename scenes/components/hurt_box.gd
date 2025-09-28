extends Area2D
class_name HurtBox

@export var health_component : Node
@export var friendly = false
@export var invincible_time = 2.0
@export var impact_reciever : CharacterBody2D
var currently_invincible = false

signal became_vulnerable
signal hurt

func _ready():
	if(invincible_time > 0):
		$InvinciblityTimer.wait_time = invincible_time
	

func damage(amount:int, impact:Vector2) -> bool:
	if(!currently_invincible):
		hurt.emit()
		health_component.hurt(amount)
		if(invincible_time > 0):
			currently_invincible = true
			$InvinciblityTimer.start()
		if(is_instance_valid(impact_reciever) && impact_reciever.has_method("apply_impact")):
			impact_reciever.apply_impact(impact)
		return true
	return false
	

func _on_invinciblity_timer_timeout():
	currently_invincible = false
	became_vulnerable.emit()
