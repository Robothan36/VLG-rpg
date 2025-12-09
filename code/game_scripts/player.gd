extends CharacterBody2D

var speed = 50
func _input(event: InputEvent) -> void:
	velocity = Vector2(0,0)
	if Global.detection == false:
		if Input.is_key_pressed(KEY_SHIFT):
			speed = 100
		else:
			speed = 50
		if Input.is_action_pressed("w"):
			velocity.y = -1 * speed

		elif Input.is_action_pressed("S"):
			velocity.y = 1 * speed

		elif Input.is_action_pressed("A"):
			velocity.x = -1 * speed

		elif Input.is_action_pressed("D"):
			velocity.x = 1 * speed
	else:
		velocity = Vector2(0,0)
	# very basic movement script, will be changed later on

func _physics_process(delta: float) -> void:
	move_and_slide()
	Global.player_position = self.position
	
