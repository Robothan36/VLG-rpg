extends Node

@onready var health: Label = $CanvasLayer/health
@onready var player: CharacterBody2D = $player

func _ready() -> void:
	player.position = Global.player_position
	

func _physics_process(delta: float) -> void:
	health.text = str(Global.health) + ("/") + str(Global.max_health) + " "

# the main script right now handling only GUI stuff
