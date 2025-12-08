extends Node

#enemy stats
@onready var enemy_health_label: Label = $visuals/enemy/enemy_health_label
@onready var enemy_name: Label = $visuals/enemy/enemy_name

#stats
@onready var health: Label = $Control/MarginContainer/HBoxContainer/stats/VBoxContainer/health
@onready var stamina: Label = $Control/MarginContainer/HBoxContainer/stats/VBoxContainer/stamina
@onready var xp: Label = $Control/MarginContainer/HBoxContainer/stats/VBoxContainer/xp




#menu
@onready var menu: MarginContainer = $Control/MarginContainer/HBoxContainer/menu
@onready var abilities: Button = $Control/MarginContainer/HBoxContainer/menu/HBoxContainer/VBoxContainer/abilities
@onready var basic_attack: Button = $"Control/MarginContainer/HBoxContainer/menu/HBoxContainer/VBoxContainer/basic attack"
@onready var items: Button = $Control/MarginContainer/HBoxContainer/menu/HBoxContainer/VBoxContainer2/items
@onready var run: Button = $Control/MarginContainer/HBoxContainer/menu/HBoxContainer/VBoxContainer2/run


#items
@onready var items_menu: MarginContainer = $Control/MarginContainer/HBoxContainer/items_menu
@onready var item_v_container: VBoxContainer = $Control/MarginContainer/HBoxContainer/items_menu/VBoxContainer/ScrollContainer/item_v_container

#attacks
@onready var fachwissen_menu: MarginContainer = $Control/MarginContainer/HBoxContainer/Fachwissen_menu
@onready var attack_container: VBoxContainer = $Control/MarginContainer/HBoxContainer/Fachwissen_menu/VBoxContainer/ScrollContainer/attack_container
@onready var player: Sprite2D = $visuals/player
@onready var enemy: Sprite2D = $visuals/enemy



var enemy_ressource

func _ready() -> void:
	
	
	items_menu.visible = false
	fachwissen_menu.visible = false
	
	if Global.enemy_ressource_paket:
		
		enemy_ressource = Global.enemy_ressource_paket.duplicate()
	else: 
		enemy_ressource = load("res://code/enemy ressources and sripts/enemy_ressources/math_teacher.tres")
		
	enemy.texture = enemy_ressource.texture
	enemy_name.text = enemy_ressource.name_of_enemy

func _process(delta: float) -> void:
	health.text = "Health: " + str(Global.health) + "/" + str(Global.max_health)
	stamina.text = "Stamina: " + str(Global.stamina) + "/" + str(Global.max_stamina)
	xp.text = "XP : " + str(Global.xp) 
	
	enemy_health_label.text = "Health: " + str(enemy_ressource.health)
	
	# the player and enemy stats are updated every frame
	# -> not needed, more efficent would be an update afer every action but it is easier this way
	
	if Global.health <= 0:
		print("player lost")
		Global.reset_game()
		get_tree().change_scene_to_file("res://scene/main.tscn")
	if enemy_ressource.health <= 0:
		print("enemy lost")
		end_fight()
			
func _on_items_pressed() -> void:
	menu.visible = false
	items_menu.visible = true
	#the menu should be hidden and the item menu should be visible now
	
	for i in Global.inventory:
		var instance = preload("res://scene/item_slot_in_menu.tscn")
		var slot = instance.instantiate()
		slot.connect("item_was_used",Callable(self,"item_used"))
		
		slot.item_name = i.name
		slot.item_var = i
			
		slot.item_function = i.function
		item_v_container.add_child(slot)
		
		# retrieves every item from the global array inventory and instances an button-scene with its name
		# button press is connected to item_used() 
	
func item_used(name_item,function,item_res):
	
	
	if GlobalItemsFunc.has_method(function):
		GlobalItemsFunc.call(function)
		print("used succesful")
		
	# important to check wether method exist or a typo happened somewhere. 
	# when is exists the funktion is beeing called
		
	else: 
		print("the method: ", function, " was not found in global_items_func")
		
	Global.inventory.erase(item_res)
	enemy_turn()
	
func _on_run_pressed() -> void:
	end_fight()

func _on_basic_attack_pressed() -> void:
	enemy_ressource.health -= Global.allgemeinwissen
	enemy_turn()

	
func enemy_turn():
	
	var instance = preload("res://scene/attack.tscn")
	var attack_scene = instance.instantiate()
	
	attack_scene.subject = enemy_ressource.subject
	add_child(attack_scene)

func _on_back_item_menu_pressed() -> void:
	for child in item_v_container.get_children():
		child.queue_free()
	
	items_menu.visible = false
	menu.visible = true


func _on_abilities_pressed() -> void:
	menu.visible = false
	fachwissen_menu.visible = true
	
	for i in Global.attack_equip:
		var instance = preload("res://scene/fachwissen_slot.tscn")
		var slot = instance.instantiate()
		
		slot.attack_name = i.name_of_attack
		slot.stamina_cost= i.stamina_cost
		slot.damage = i.damage
		slot.heal = i.self_heal
		
		slot.connect("attack_used",Callable(self,"player_attack"))
		
		attack_container.add_child(slot)
		


func _on_back_attack_menu_pressed() -> void:
	for child in attack_container.get_children():
		child.queue_free()
	
	fachwissen_menu.visible = false
	menu.visible = true


func player_attack(damage,heal):
	Global.health += heal
	
	enemy_ressource.health -= damage
	
	enemy_turn()
	
func end_fight():
	Global.save_game()
	Global.load_game()
	get_tree().change_scene_to_file("res://scene/main.tscn")
