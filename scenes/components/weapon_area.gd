extends Area2D

@export var damage : int = 1
@export var friendly = false
@export var impact : Vector2

signal attacked

func _on_area_entered(area):
	attack_area(area)

	
func attack_area(area):
	if(area is HurtBox):
		if(!is_instance_valid(area) || not area in get_overlapping_areas()):
			area.became_vulnerable.disconnect(attack_area)
			return
		if(friendly != area.friendly):
			var landed = area.damage(damage, impact)
			if(landed):
				attacked.emit()
			if(!area.became_vulnerable.is_connected(attack_area)):
				area.became_vulnerable.connect(attack_area.bind(area))
