extends CharacterBody2D

var speed = 50

func _input(event: InputEvent) -> void:
	
	velocity = Vector2(0,0)
	
	if Input.is_action_pressed("w"):
		velocity.y = -1 * speed
	
		
	elif Input.is_action_pressed("S"):
		velocity.y = 1 * speed
		
	if Input.is_action_pressed("A"):
		velocity.x = -1 * speed
		
	if Input.is_action_pressed("D"):
		velocity.x = 1 * speed
		
	# verry basic movement script, will be changed later on	
		
func _physics_process(delta: float) -> void:
	move_and_slide()
