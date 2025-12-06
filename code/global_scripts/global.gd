extends Node


var health : float
var max_health : float
var xp : float
var inventory : Array
var stamina : int
var max_stamina: int

func _ready() -> void:
	reset_game()


func reset_game():
	health = 5
	max_health = 10.0
	xp = 0
	stamina = 2
	max_stamina = 10
	inventory = []

	
# reset_game is beeing called to resest every global variable
# reset_game() has to contain every global variable which is supposed to be  reseted
	
	
