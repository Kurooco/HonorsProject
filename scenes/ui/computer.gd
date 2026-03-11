extends Control

var money = 0
var displayed_money = 0.0
var lines = 0
var money_per_sec = 0
var time = 0.0

func _ready() -> void:
	time = 0.0


func _process(delta: float) -> void:
	time += delta*3
	set_clock()
	var ori_string = str(money)
	var new_string = ""
	for c in range(ori_string.length()-1, -1, -1):
		new_string += ori_string[ori_string.length()-1-c]
		if(c % 3 == 0 && c > 0):
			new_string += ","
	displayed_money = new_string#lerp(displayed_money, float(money), 1 - pow(.05, delta))
	$MoneyCounter.text = "Money: $"+str(displayed_money)


func _on_make_money_pressed() -> void:
	write_line("Money!")
	money += 1


func _on_lotto_pressed() -> void:
	if(randi() % 1000 == 0):
		money += 10000
		write_line("HOLY COWBIRD YOU WON THE LOTTO!!!!!!")
	else:
		write_line("Stop wasting your money and get back to work.")


func write_line(line):
	$TextEdit.text += "- "+line+"\n"
	lines += 1
	$TextEdit.scroll_vertical = lines


func _on_bonds_pressed() -> void:
	write_line("That will pay off eventually.")
	var new_timer = get_tree().create_timer(randf_range(10.0, 30.0))
	new_timer.timeout.connect(pay_bond)

func pay_bond():
	var amount = randi() % 70
	money += amount
	write_line("You got $"+str(amount)+" from a bond.")


func _on_invest_pressed() -> void:
	var first = ["Super", "Excellent", "Trouble", "Frank", "Tabular", "Double", "Supreme", "Nice", "Ligit"]
	var second = ["Bird", "Apple", "Saw", "Knife", "Cage", "Dodo", "Squeeze", "Flight", "Plane", "Line", "Yolk", "Money", "Bank"]
	var third = ["co", "inc"]
	var company_name = first.pick_random()+second.pick_random()+" "+third.pick_random()
	write_line("You invested in "+company_name+"!")
	money_per_sec += randi_range(1, 3)
	
func return_investment(amount, company_name):
	money += amount
	write_line("You got $"+str(amount)+" from you investment in "+company_name+"!")


func _on_invest_2_pressed() -> void:
	var first = ["Powerful", "Greedy", "Super", "Excellent", "Troubled", "Frank", "Tabular", "Double", "Supreme", "Nice", "Ligit"]
	var second = ["Nova", "AI", "Tech", "Solutions", "Power", "Greed"]
	var third = ["co", "inc"]
	var company_name = first.pick_random()+second.pick_random()+" "+third.pick_random()
	if(randi()% 2 == 0):
		write_line("You invested in "+company_name+", and the company was a huge success!")
		money_per_sec += randi_range(30, 80)
	else:
		write_line("You invested in "+company_name+", and the company failed immediately afterwards.")

func set_clock():
	var start_time = 480
	var current_time = start_time + int(time)
	var hour = ((current_time/60)%12+1)
	var min = ("0" if current_time%60 < 10 else "") + str(current_time%60)
	$Clock.text = str(hour) +":"+ min + ("am" if current_time < 660 else "pm")
	if(hour == 5):
		set_process(false)
		PlayerStats.nighttime = true
		Autoload.level_handler.set_level_with_spawn_point("res://scenes/levels/ending_interior.tscn", "computer")

func _on_timer_timeout() -> void:
	money += money_per_sec


func _on_country_pressed() -> void:
	money_per_sec += randi_range(10000,50000)


func _on_company_pressed() -> void:
	money_per_sec += randi_range(250, 500)


func _on_city_pressed() -> void:
	money_per_sec += randi_range(3000, 8000)
