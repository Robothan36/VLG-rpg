extends Button
signal item_was_used


var item_name : String
var item_function : String

#just a button that emitts an signal with his own name and function when beeing pressed

func _ready() -> void:
	self.text = item_name
		
func _on_pressed() -> void:
	emit_signal("item_was_used",item_name,item_function)
	self.queue_free()
