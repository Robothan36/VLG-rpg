extends Node

@onready var health: Label = $CanvasLayer/health
@onready var player: CharacterBody2D = $player
@onready var enemy_container: Node2D = $enemy_container

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
