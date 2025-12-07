extends CharacterBody2D
class_name enemy

@export var enemyData: enemy_data


@onready var ray_cast_2d: RayCast2D = $RayCast2D
var detected_player = false
var speed = 0.5

func _physics_process(delta: float) -> void:
	if ray_cast_2d.get_collider() and detected_player == false:
		var col = ray_cast_2d.get_collider()
		if col.name == "player":
			print("player spotted")
			detected_player = true
			velocity = ( col.position - self.position ) * speed
	# this check is the enemy sees the player via raycast2d
				
				
	if move_and_slide():
		if self.get_last_slide_collision().get_collider().name == "player":
			
			velocity = Vector2.ZERO
			
			# now the enemy has collided with the player and the fight has to start
			
			Global.enemy_ressource_paket = enemyData
			
			get_tree().change_scene_to_file("res://scene/fighting.tscn")
			
			
			
			self.queue_free()
			
		#pass

	
