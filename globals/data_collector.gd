extends Node

# stats overall
var global_stats = {}
# stats overall and per-level
var general_stats = {"jumps":0,"points":0,"deaths":0,"bounces":0}
# stats per-level. Automatically copied from general_stats
var level_stats : Array[Dictionary]
var participant_num = 0
var enabled = false

func _ready():
	await get_tree().physics_frame
	for levels in Autoload.level_handler.level_order:
		level_stats.append(general_stats.duplicate())

func enable():
	enabled = true
	#participant_num = DirAccess.get_directories_at("data").size()
	var count_file = FileAccess.open("data/count.txt", FileAccess.READ_WRITE)
	participant_num = int(count_file.get_line())
	print_debug(participant_num)
	count_file.seek(0)
	count_file.store_line(str(participant_num+1))
	count_file.close()
		
func set_stat(stat_name:String, value):
	if(stat_name in general_stats.keys()):
		general_stats[stat_name] = value
		update_general_file()
		if(Autoload.level_handler.level_number != -1):
			level_stats[Autoload.level_handler.level_number][stat_name] = value
			update_level_file(Autoload.level_handler.level_number)
	if(stat_name in global_stats.keys()):
		global_stats[stat_name] = value
		update_global_file()
	
func increment_stat(stat_name:String, amount=1):
	if(stat_name in general_stats.keys()):
		general_stats[stat_name] += amount
		update_general_file()
		if(Autoload.level_handler.level_number != -1):
			level_stats[Autoload.level_handler.level_number][stat_name] += amount
			update_level_file(Autoload.level_handler.level_number)
	if(stat_name in global_stats.keys()):
		global_stats[stat_name] += amount
		update_global_file()

func update_stat_file(path: String, dict: Dictionary):
	if(enabled):
		if(!DirAccess.dir_exists_absolute(path)):
			DirAccess.make_dir_recursive_absolute(path)
		var file = FileAccess.open(path+"/stats"+str(participant_num)+".txt", FileAccess.WRITE)
		file.store_line(",".join(dict.values()))
		file.close()

func update_global_file():
	update_stat_file("res://data/global_stats", global_stats)


func update_general_file():
	update_stat_file("res://data/general_stats", general_stats)


func update_level_file(level:int):
	var dir = "res://data/level"+str(level)+"/"
	update_stat_file(dir, level_stats[level])
