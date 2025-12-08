extends Control

var attack_name: String
var stamina_cost: int
var damage : int
var heal : int

var play_able = true

@onready var button: Button = $Button
@onready var description: Label = $description
@onready var cost: Label = $cost

signal attack_used

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if play_able == false: 
		button.visible = false
	cost.text = "cost: " + str(stamina_cost)
	description.text = "this will do " + str(damage)  + " damage"
	
	button.text = "play"
	

func _physics_process(delta: float) -> void:
	
	
	
	if (Global.stamina - stamina_cost) < 0:
		button.disabled = true
		
	else:
		button.disabled = false

func _on_button_pressed() -> void:
	if (Global.stamina - stamina_cost) >= 0:
		Global.stamina -= stamina_cost
		emit_signal("attack_used",damage,heal)
	else:
		print("not enough stamina")
