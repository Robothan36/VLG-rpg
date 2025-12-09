extends Control

# menu
@onready var items: Button = $MarginContainer/menu/items
@onready var speichern: Button = $MarginContainer/menu/speichern
@onready var laden: Button = $MarginContainer/menu/laden
@onready var fähigkeiten: Button = $MarginContainer/menu/fähigkeiten
@onready var zurück: Button = $MarginContainer/menu/zurück
@onready var menu: VBoxContainer = $MarginContainer/menu

#item 
@onready var item_v_container: VBoxContainer = $MarginContainer/items_menu/VBoxContainer/ScrollContainer/item_v_container
@onready var items_menu: MarginContainer = $MarginContainer/items_menu

#fähigkeiten
@onready var fähigkeiten_menu: MarginContainer = $MarginContainer/fähigkeiten_menu
@onready var fähigkeiten_v_container: VBoxContainer = $MarginContainer/fähigkeiten_menu/VBoxContainer/ScrollContainer/fähigkeiten_v_container

func _physics_process(delta: float) -> void:
	get_parent().get_node("health").text =  str(Global.health) + ("/") + str(Global.max_health) + " "
	get_parent().get_node("stamina").text = str(Global.stamina) + "/" + str(Global.max_stamina) + " "
	
		
	
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	menu.visible = true
	items_menu.visible = false
	fähigkeiten_menu.visible = false
	

func _on_items_pressed() -> void:
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
				
		# retrieves every item from the global array inventory and instances an button-scene with its name
		# button press is connected to item_used() 
	
func item_used(name_item,function,item_res):
	
	if GlobalItemsFunc.has_method(function):
		GlobalItemsFunc.call(function)
		print("used succesful")
		
	else: 
		print("the method: ", function, " was not found in global_items_func")
		Global.inventory.erase(item_res)
	
	
func _on_speichern_pressed() -> void:
	Global.save_game()

func _on_laden_pressed() -> void:
	Global.load_game()

func _on_fähigkeiten_pressed() -> void:
	menu.visible = false
	fähigkeiten_menu.visible = true
	for i in Global.attack_equip:
		var instance = preload("res://scene/fachwissen_slot.tscn")
		var slot = instance.instantiate()
		#slot.connect("item_was_used",Callable(self,"item_used"))
		slot.play_able = false
		slot.attack_name = i.name_of_attack
		slot.stamina_cost= i.stamina_cost
		slot.damage = i.damage
		slot.heal = i.self_heal
			
		
		fähigkeiten_v_container.add_child(slot)
				
	
func _on_zurück_pressed() -> void:
	get_tree().paused = false
	self.queue_free()

func _on_back_item_menu_pressed() -> void:
	menu.visible = true
	items_menu.visible = false
	fähigkeiten_menu.visible = false

func _on_back_fähigkeiten_menu_pressed() -> void:
	menu.visible = true
	items_menu.visible = false
	fähigkeiten_menu.visible = false
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("open_menu"):
		get_tree().paused = false
		
		self.queue_free()
