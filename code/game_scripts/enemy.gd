extends CharacterBody2D
class_name enemy

@export var enemyData: enemy_data
@onready var sprite_2d: Sprite2D = $Sprite2D

enum orientation_list {left, right, up, down}
@export var orientation: orientation_list

@onready var ray_cast_2d: RayCast2D = $RayCast2D

var detected_player = false

func _ready() -> void:
	sprite_2d.texture = sprite_2d.texture.duplicate()
	var atlas = sprite_2d.texture as AtlasTexture
	
	match orientation:
		orientation_list.up:
			ray_cast_2d.rotation = -PI/2
			atlas.region = Rect2(0, 32, 32, 32)
		orientation_list.down:
			ray_cast_2d.rotation = PI/2
			atlas.region = Rect2(32, 32, 32, 32)
		orientation_list.right:
			ray_cast_2d.rotation = 0
			atlas.region = Rect2(0, 0, 32, 32)
		orientation_list.left:
			ray_cast_2d.rotation = PI
			atlas.region = Rect2(32, 0, 32, 32)

func _physics_process(delta: float) -> void:
	if ray_cast_2d.get_collider() and detected_player == false:
		var col = ray_cast_2d.get_collider()
		if col.name == "player":
			Global.detection = true
			print("player spotted")
			detected_player = true

	if move_and_slide():
		if self.get_last_slide_collision().get_collider().name == "player":
			Global.enemy_ressource_paket = enemyData
			Global.save_game()
			Global.defeated_enemy_array.append(self.name)
			get_tree().change_scene_to_file("res://scene/fighting.tscn")
