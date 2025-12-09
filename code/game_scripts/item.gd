extends Node2D

@export var item_data: ItemData
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print(self.name, " is here")
	$Sprite2D.texture = item_data.icon

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		print(item_data.name, " has been collected")
		Global.inventory.append(item_data)
		Global.used_item_array.append(self.name)
		self.queue_free()
