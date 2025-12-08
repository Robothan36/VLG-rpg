extends Node

var save_path = "user://savestate.save"
var attack_equip : Array
var health : int
var max_health : int
var xp : float
var inventory : Array
var stamina : int
var max_stamina: int

var allgemeinwissen : float

var enemy_ressource_paket : Resource

var player_position = Vector2(70,-340)

var defeated_enemy_array = []

func _ready() -> void:
	reset_game()
	#load_game()


func reset_game():
	
	defeated_enemy_array = []
	player_position = Vector2(70,-340)
	
	var attack_1 = load("res://code/player_attack_resource/ressource/benutzt_fachsprache.tres")
	var attack_2 = load("res://code/player_attack_resource/ressource/pq_formel.tres")
	var attack_3 = load("res://code/player_attack_resource/ressource/Periodensystem.tres")
	attack_equip.append(attack_1)
	attack_equip.append(attack_2)
	attack_equip.append(attack_3)
	
	print(attack_equip," are the equipted attacks")
	# nur vorübergehend zum testen
	
	
	allgemeinwissen = 1
	health = 60
	max_health = 60
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
	file.store_var(save_res(attack_equip))
	print("save was : ", save_res(attack_equip))
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
		attack_equip = load_res(file.get_var(),"res://code/player_attack_resource/ressource/")
		
		player_position = file.get_var()
		print("save was succesful")

	else: 
		print("save file was not found")
		
		
		
		
func save_res(array):
	print(array, " this array was commited")
	var saved_array = []
	
	for i in array:
		saved_array.append(i.id)
		
	print(saved_array, "this is the saved array")
	return saved_array
	
		
func load_res(encoded_array,path):
	print("loading process started")
	print("the encoded array recieved was: ", encoded_array)
	var decoded_array = []
	for i in encoded_array:
		var dir := DirAccess.open(path)

		if dir:
			dir.list_dir_begin()
			var file_name = dir.get_next()

			while file_name != "":
				if not dir.current_is_dir():  
					# nur Dateien, keine Unterordner
									
					# Pfad erstellen
					var full_path = path + file_name 
					var res = load(full_path)
				
					print(i,res.id)
					if res.id == i:
						decoded_array.append(res)
					
					file_name = dir.get_next()
					
		dir.list_dir_end()
	print("the dencoded array recieved was: ", decoded_array)
	return decoded_array
	
	
