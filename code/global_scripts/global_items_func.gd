extends Node

# returning elements that may be used a couple of times
func check_if_max_is_exceeded(current,max):
	if current > max:
		return true

# item functions

func monster_white():
	print("monster white is beeing used --- ")
	var gain = 3
	Global.stamina = Global.stamina + gain
	if check_if_max_is_exceeded(Global.stamina,Global.max_stamina) == true:
		Global.stamina = Global.max_stamina
	
func dextro_energy():
	print("dextro is beeing used ---- ")
	var gain = 1
	Global.stamina = Global.stamina + gain
	if check_if_max_is_exceeded(Global.stamina,Global.max_stamina) == true:
		Global.stamina = Global.max_stamina
	
func space_kecks():
	print("space kecks is beeing used --- ")
	var gain = 2
	Global.health = Global.health + gain
	if check_if_max_is_exceeded(Global.health,Global.health) == true:
		Global.health = Global.health
	
	
# functions that are beeing called upon item consumption
# right now only placeholders
