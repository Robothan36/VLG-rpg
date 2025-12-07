extends Resource
class_name playerAttackData

enum subject_pool{
Naturwissenschaft, 
Sprache,
Geselschaftswissenschaft,
Kunst,
interdisziplinär
 }

@export var related_subject:subject_pool

@export var name_of_attack : String
@export var damage : int

@export var stamina_cost : int

@export var self_heal := 0
@export var causes_status_effect := false
