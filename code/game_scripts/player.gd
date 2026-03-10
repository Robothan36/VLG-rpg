extends CharacterBody2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

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
			sprite_2d.texture = preload("res://assests/bob orientations/up.tres")

		elif Input.is_action_pressed("S"):
			velocity.y = 1 * speed
			sprite_2d.texture = preload("res://assests/bob orientations/down.tres")

		elif Input.is_action_pressed("A"):
			
			velocity.x = -1 * speed
			sprite_2d.texture = preload("res://assests/bob orientations/left.tres")

		elif Input.is_action_pressed("D"):
			velocity.x = 1 * speed
			sprite_2d.texture = preload("res://assests/bob orientations/right.tres")
	else:
		velocity = Vector2(0,0)
	# very basic movement script, will be changed later on

func _physics_process(delta: float) -> void:
	move_and_slide()
	Global.player_position = self.position
	
	if velocity != Vector2.ZERO: 
		audio_stream_player_2d.play()
		print("player steps")
		
		
	if velocity == Vector2.ZERO: 
		audio_stream_player_2d.stop()
	
	
