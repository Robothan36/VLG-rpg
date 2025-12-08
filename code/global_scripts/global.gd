extends Node

var save_path = "user://savestate.save"
var attack_equip : Array
var health : float
var max_health : float
var xp : float
var inventory : Array
var stamina : int
var max_stamina: int

var allgemeinwissen : float

var enemy_ressource_paket : Resource

var player_position = Vector2(70,-340)

func _ready() -> void:
	reset_game()
	load_game()


func reset_game():
	
	
	var attack_1 = load("res://code/player_attack_resource/ressource/benutzt_fachsprache.tres")
	var attack_2 = load("res://code/player_attack_resource/ressource/pq_formel.tres")
	attack_equip.append(attack_1)
	attack_equip.append(attack_2)
	print(attack_equip," are the equipted attacks")
	# nur vorübergehend zum testen
	
	
	allgemeinwissen = 1
	health = 40
	max_health = 80
	xp = 0
	stamina = 10
	max_stamina = 10
	inventory = []

	
# reset_game is beeing called to resest every global variable
# reset_game() has to contain every global variable which is supposed to be  reseted


func save_game(): 
	var file = FileAccess.open(save_path,FileAccess.WRITE)
	file.store_var(health)
	# 1 health
	file.store_var(xp)
	# 2 xp
	file.store_var(stamina)
	# 3 stamina
	file.store_var(inventory)
	# 4 inventory
	file.store_var(attack_equip)
	# 5 attack equip
	file.store_var(player_position)
	# 6 player position
	print("Game was saved")
	
func load_game():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path,FileAccess.READ)
		print("save was succesful")
		health = file.get_var()
		xp = file.get_var()
		stamina = file.get_var()
		inventory = file.get_var()
		attack_equip = file.get_var()
		player_position = file.get_var()
		print("save was succesful")

	else: 
		print("save file was not found")
		
		
	
	
	
	
