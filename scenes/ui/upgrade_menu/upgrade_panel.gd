extends PanelContainer

@export var title : String
@export var icon : Texture
@export var description : String
@export var upgrade_var_name : String
@export var cost_progrssion : Array[int]
var upgrade_amount
var upgrades = 0
var progress_tween : Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	upgrade_amount = cost_progrssion.size()
	upgrades = PlayerStats.get(upgrade_var_name)
	%Progress.texture_under = icon
	%Progress.texture_progress = icon
	%Description.text = description
	update_display()


func update_display():
	%Title.text = title + " - LV" + str(upgrades+1)
	if(is_instance_valid(progress_tween)):
		progress_tween.kill()
	progress_tween = create_tween()
	progress_tween.tween_property(%Progress, "value", (float(upgrades)/upgrade_amount)*100, .5).set_trans(Tween.TRANS_QUART)
	if(upgrades < upgrade_amount):
		%Upgrade.text = str(cost_progrssion[upgrades]) + " SP"
	else:
		%Upgrade.text = "MAX"
		%Upgrade.disabled = true

func _on_upgrade_pressed():
	upgrades += 1
	PlayerStats.set(upgrade_var_name, PlayerStats.get(upgrade_var_name)+1)
	PlayerStats.update_player_stats()
	update_display()
