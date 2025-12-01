extends Node

# stats overall
var global_stats = {}
# stats overall and per-level
var general_stats = {"jumps":0,"points":0,"deaths":0}
# stats per-level. Automatically copied from general_stats
var level_stats : Array[Dictionary]

func set_stat(stat_name:String, value):
	if(stat_name in general_stats.keys()):
		general_stats[stat_name] = value
	update_file()
	
func increment_stat(stat_name:String, amount=1):
	if(stat_name in general_stats.keys()):
		general_stats[stat_name] += amount
	update_file()

func update_file():
	var file = FileAccess.open("res://data/stats.txt", FileAccess.WRITE)
	file.store_line(",".join(general_stats.values()))
	file.close()
