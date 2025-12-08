extends Node

@onready var health: Label = $CanvasLayer/health
@onready var player: CharacterBody2D = $player
@onready var enemy_container: Node2D = $enemy_container
@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var item_container: Node2D = $item_container

var menu_open = false

func _ready() -> void:
	player.position = Global.player_position
	check_for_defeated_enemy()
	

func _physics_process(delta: float) -> void:
	health.text = str(Global.health) + ("/") + str(Global.max_health) + " "

# the main script right now handling only GUI stuff
func check_for_defeated_enemy():
	
	for i in enemy_container.get_children():
		for j in Global.defeated_enemy_array:
			print(i,j)
			if i.name == j:
				i.queue_free()
	print(Global.used_item_array)
	for i in item_container.get_children():
		for j in Global.used_item_array:
			print(i,j)
			if i.name == j:
				i.queue_free()
				
func _input(event: InputEvent) -> void:
	#print(menu_open)
	
	if Input.is_action_just_pressed("open_menu"):
	

		var instance = preload("res://scene/menu.tscn")
		var menu = instance.instantiate()
		
	
		get_tree().paused = true
		
		canvas_layer.add_child(menu)
