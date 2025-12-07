extends Node

var path = "res://code/attack_script and ressources/resources/"

var attack_pool = []
var subject

func _ready() -> void:
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
					attack_pool.append(res)
				
				file_name = dir.get_next()
				
		dir.list_dir_end()
		
		# über jedes Element im Ordner iterieren und alle ressources mit selebn Fach in attack.pool hinzufügen
		
		
		print("attack pool is: ", attack_pool.name)
		
		

		
