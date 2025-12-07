extends Node

var attack_equip : Array
var health : float
var max_health : float
var xp : float
var inventory : Array
var stamina : int
var max_stamina: int

var allgemeinwissen : float

var enemy_ressource_paket : Resource


func _ready() -> void:
	reset_game()


func reset_game():
	
	var attack_1 = load("res://code/player_attack_resource/ressource/benutzt_fachsprache.tres")
	var attack_2 = load("res://code/player_attack_resource/ressource/pq_formel.tres")
	attack_equip.append(attack_1)
	attack_equip.append(attack_2)
	print(attack_equip," are the equipted attacks")
	# nur vorübergehend zum testen
	
	
	allgemeinwissen = 1
	health = 5
	max_health = 10.0
	xp = 0
	stamina = 2
	max_stamina = 10
	inventory = []

	
# reset_game is beeing called to resest every global variable
# reset_game() has to contain every global variable which is supposed to be  reseted
	
	
