extends Control

var money = 0
var lines = 0

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	$MoneyCounter.text = "Money: $"+str(money)


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
	var timer = Timer.new()
	timer.autostart = true
	timer.one_shot = false
	timer.wait_time = randi_range(5, 15)
	var amount = randi_range(5, 10)
	timer.timeout.connect(return_investment.bind(amount, company_name))
	add_child(timer)
	
func return_investment(amount, company_name):
	money += amount
	write_line("You got $"+str(amount)+" from you investment in "+company_name+"!")


func _on_invest_2_pressed() -> void:
	var first = ["Super", "Excellent", "Troubled", "Frank", "Tabular", "Double", "Supreme", "Nice", "Ligit"]
	var second = ["Nova", "AI", "Tech", "Solutions", "Power", "Greed"]
	var third = ["co", "inc"]
	var company_name = first.pick_random()+second.pick_random()+" "+third.pick_random()
	if(randi()% 2 == 0):
		write_line("You invested in "+company_name+", and the company turned out to be a huge success!")
		var timer = Timer.new()
		timer.autostart = true
		timer.one_shot = false
		timer.wait_time = randi_range(5, 15)
		var amount = randi_range(50, 250)
		timer.timeout.connect(return_investment.bind(amount, company_name))
		add_child(timer)
	else:
		write_line("You invested in "+company_name+", and the company failed immediately afterwards.")
