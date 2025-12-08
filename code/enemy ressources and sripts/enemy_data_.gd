extends Resource
class_name enemy_data

enum subject_pool{
Naturwissenschaft, 
Sprache,
Geselschaftswissenschaft,
Kunst,
interdisziplinär
 }

enum difficulties {
	easy,
	standard,
	diffuclt,
	boss}

@export var id: String
@export var name: String
@export var description: String
@export var texture: Texture2D
@export var subject: subject_pool
@export var health: int
@export var strenght : float
@export var function: String
 
# template for item ressource
# new varialbe that may be added may be changed for the others ressources
