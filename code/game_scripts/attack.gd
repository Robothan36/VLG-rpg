extends Node

var path = "res://code/attack_script and ressources/resources/"

var attack_pool = {
	
}
var subject
var rng = RandomNumberGenerator.new()


func _ready() -> void:
	rng.randomize()
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
			
				
				if res.related_subject == subject:
					attack_pool[res] = res.prop
				
				file_name = dir.get_next()
				
		dir.list_dir_end()
		
		# über jedes Element im Ordner iterieren und alle ressources
		# mit selebn Fach in dic attack pool hinzufügen
		print("attack pool is: ", attack_pool)
				
	
		var attack = chose_random_attack_with_prop()
		print(attack.name_of_attack, " ---- was chosen" )
		use_attack(attack)
		

func use_attack(attack):
	var incoming_damage = attack.damage * get_parent().enemy_ressource.strenght
	Global.health -= incoming_damage
	get_parent().enemy_ressource.health += attack.self_heal
	
	# Hier wird die Attack ausgeführt
			
			
func chose_random_attack_with_prop():
	var sum = 0
	for i in attack_pool:
		#print(i.name_of_attack, " - ", i.prop)
		sum += i.prop
		
	#es wird die summe der ganzen Wahrscheinlichkeiten gebildet
	var r = rng.randi_range(1,sum)
	var accum = 0
	
	for i in attack_pool:
		accum += i.prop
		
		if r <= accum:
			return i
			# eine Attack wird zurückgeggeben
		
			
		
		
		

		
