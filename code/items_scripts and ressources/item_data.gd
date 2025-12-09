extends Resource
class_name ItemData

enum ItemType { CONSUMABLE, KEY, EQUIPMENT }

@export var id: String
@export var name: String
@export var description: String
@export var icon: Texture2D
@export var type: ItemType
@export var function: String
 
# template for item ressource
# new varialbe that may be added may be changed for the others ressources
