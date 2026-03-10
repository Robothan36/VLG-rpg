extends Node
var info_text := ""
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

# info
@onready var info: MarginContainer = $Control/MarginContainer/HBoxContainer/info
@onready var info_label: Label = $Control/MarginContainer/HBoxContainer/info/info_label

# other stuff
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var enemy_ressource

# -------------------------------------------------
# INFO TEXT FUNCTION
# -------------------------------------------------

		
func show_info(text):
	menu.visible = false
	items_menu.visible = false
	fachwissen_menu.visible = false
	info_label.text = text
	info.visible = true
	
	if animation_player:
		animation_player.play("info_animation")
	
# ENGINE FUNCTIONS
# -------------------------------------------------

func _ready() -> void:
	menu.visible = true
	info.visible = false
	
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
	
	if Global.health <= 0:
		print("player lost")
		Global.reset_game()
		get_tree().change_scene_to_file("res://scene/main.tscn")
		Global.detection = false
		
	if enemy_ressource.health <= 0:
		print("enemy lost")
		end_fight()

# -------------------------------------------------
# MENU BUTTONS
# -------------------------------------------------

func _on_items_pressed() -> void:

	info.visible = false
	menu.visible = false
	items_menu.visible = true
	
	for i in Global.inventory:
		
		var instance = preload("res://scene/item_slot_in_menu.tscn")
		var slot = instance.instantiate()
		
		slot.connect("item_was_used",Callable(self,"item_used"))
		
		slot.item_name = i.name
		slot.item_var = i
		slot.item_function = i.function
		
		item_v_container.add_child(slot)

func _on_abilities_pressed() -> void:

	info.visible = false
	menu.visible = false
	fachwissen_menu.visible = true
	
	for i in Global.attack_equip:
		
		var instance = preload("res://scene/fachwissen_slot.tscn")
		var slot = instance.instantiate()
		
		slot.attack_name = i.name_of_attack
		slot.stamina_cost = i.stamina_cost
		slot.damage = i.damage
		slot.heal = i.self_heal
		
		slot.connect("attack_used",Callable(self,"player_attack"))
		
		attack_container.add_child(slot)

func _on_basic_attack_pressed() -> void:

	info.visible = false
	
	enemy_ressource.health -= Global.allgemeinwissen
	
	show_info("Du benutzt dein Allgemeinwissen und machst " + str(Global.allgemeinwissen) + " Eindruck!")
	await get_tree().create_timer(1.5).timeout
	enemy_turn()

func _on_run_pressed() -> void:
	end_fight()

# -------------------------------------------------
# PLAYER ACTIONS
# -------------------------------------------------

func player_attack(damage,heal):

	Global.health += heal
	enemy_ressource.health -= damage
	
	show_info("Du benutzt dein Fachwissen und machst " + str(damage) + " Eindruck!")
	await get_tree().create_timer(1.5).timeout
	
	enemy_turn()

func item_used(name_item,function,item_res):

	if GlobalItemsFunc.has_method(function):
		GlobalItemsFunc.call(function)
		show_info("Du benutzt " + name_item + "!")
	else: 
		print("the method: ", function, " was not found in global_items_func")
		
	Global.inventory.erase(item_res)
	
	show_info("Du benutzt "+ str(name_item))
	await get_tree().create_timer(1.5).timeout
	
	enemy_turn()

# -------------------------------------------------
# BACK BUTTONS
# -------------------------------------------------

func _on_back_item_menu_pressed() -> void:
	
	for child in item_v_container.get_children():
		child.queue_free()
	
	items_menu.visible = false
	menu.visible = true

func _on_back_attack_menu_pressed() -> void:
	
	for child in attack_container.get_children():
		child.queue_free()
	
	fachwissen_menu.visible = false
	menu.visible = true

# -------------------------------------------------
# FIGHT LOGIC
# -------------------------------------------------

func end_fight():

	Global.save_game()
	Global.load_game()
	Global.detection = false
	
	get_tree().change_scene_to_file("res://scene/main.tscn")

func enemy_turn():

	end_player_turn()
	
	
	
	var instance = preload("res://scene/attack.tscn")
	var attack_scene = instance.instantiate()
	
	attack_scene.subject = enemy_ressource.subject
	
	add_child(attack_scene)
	show_info(enemy_ressource.name_of_enemy + " benutzt " + Global.last_enemy_attack)
func end_player_turn():

	for child in attack_container.get_children():
		child.queue_free()
		
	for child in item_v_container.get_children():
		child.queue_free()
