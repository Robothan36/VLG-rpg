extends Node

#stats
@onready var health: Label = $Control/HBoxContainer/stats/VBoxContainer/health
@onready var stamina: Label = $Control/HBoxContainer/stats/VBoxContainer/stamina
@onready var xp: Label = $Control/HBoxContainer/stats/VBoxContainer/xp


#menu
@onready var menu: MarginContainer = $Control/HBoxContainer/menu
@onready var abilities: Button = $Control/HBoxContainer/menu/HBoxContainer/VBoxContainer/abilities
@onready var basic_attack: Button = $"Control/HBoxContainer/menu/HBoxContainer/VBoxContainer/basic attack"
@onready var items: Button = $Control/HBoxContainer/menu/HBoxContainer/VBoxContainer2/items
@onready var run: Button = $Control/HBoxContainer/menu/HBoxContainer/VBoxContainer2/run


#items
@onready var items_menu: MarginContainer = $Control/HBoxContainer/items_menu
@onready var item_v_container: VBoxContainer = $Control/HBoxContainer/items_menu/item_v_container



func _process(delta: float) -> void:
	health.text = "Health: " + str(Global.health) + "/" + str(Global.max_health)
	stamina.text = "Stamina: " + str(Global.stamina) + "/" + str(Global.max_stamina)
	xp.text = "XP : " + str(Global.xp) 
	
	# the player stats are updated every frame
	# -> not needed, more efficent would be an update afer every action but it is easier this way
	
func _on_items_pressed() -> void:
	menu.visible = false
	items_menu.visible = true
	#the menu should be hidden and the item menu should be visible now
	
	for i in Global.inventory:
		var instance = preload("res://scene/item_slot_in_menu.tscn")
		var slot = instance.instantiate()
		slot.connect("item_was_used",Callable(self,"item_used"))
		
		slot.item_name = i.name
			
		slot.item_function = i.function
		item_v_container.add_child(slot)
		
		# retrieves every item from the global array inventory and instances an button-scene with its name
		# button press is connected to item_used() 
	
func item_used(name,function):
	
	
	if GlobalItemsFunc.has_method(function):
		GlobalItemsFunc.call(function)
		print("used succesful")
		
	# important to check wether method exist or a typo happened somewhere. 
	# when is exists the funktion is beeing called
		
	else: 
		print("the method: ", function, " was not found in global_items_func")
	
	
