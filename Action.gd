class_name Action extends Resource

@export
var name: String = "Item Name"

func get_result(user: Character, target: Character) -> ActionResult:
	return ActionResult.new()
	
func equals(action: Action) -> bool:
	return false
	
	
