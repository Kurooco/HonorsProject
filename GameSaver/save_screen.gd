extends CanvasLayer

@export var game_saver : Node
var selected_slot = -1

@onready var save_slots = $Panel/SaveSlots

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_save_slots_item_selected(index):
	$Panel/SaveButton.disabled = false
	$Panel/LoadButton.disabled = false
	selected_slot = index

func _on_save_button_button_down():
	game_saver.save_level()
	var meta = SaveMetadata.new()
	meta.example = str(randi()%100)
	game_saver.save_game(selected_slot, meta)
	reset_buttons()
	save_slots.set_item_custom_bg_color(selected_slot, Color(.5,.5,0,1))
	save_slots.set_item_text(selected_slot, "Saved!")

func _on_show_button_pressed():
	$Panel.visible = !$Panel.visible
	reset_buttons()

func reset_buttons():
	save_slots.clear()
	var ind = 0
	for slot in game_saver.slot_names:
		var img = get_external_texture("user://save/"+slot+"/screenshot.png")
		if(!is_instance_valid(img)):
			img = load("res://GameSaver/empty.png")
			save_slots.add_item(slot, img)
		else:
			save_slots.add_item(slot+" - "+game_saver.get_save_metadata(ind).example, img)
		ind += 1
# From: https://github.com/godotengine/godot-docs/issues/2148
func get_external_texture(path):
	var img = Image.new()
	img.load(path)
	var texture = ImageTexture.new()
	return texture.create_from_image(img)

func _on_load_button_pressed():
	game_saver.load_game(selected_slot)
	game_saver.load_level()
	$Panel.hide()
