extends Node2D
class_name item


@export var item_data: ItemData
#uses ressources in code folder
# this script should need to be updated any time soon, I think



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		print("i have been collected")
		Global.inventory.append(item_data.id)
		self.queue_free()
		
# just checks if item is picked up. if it is, Item leaves the world and ressource enters global inventory array
