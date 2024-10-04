class_name Dodge extends Action

@export_range(0, 100)
var chance_of_success: int

func get_result(user: Character, target: Character) -> DodgeResult:
	var result = DodgeResult.new()
	var random = randi_range(0, 100)		
	
	var success = chance_of_success <= random
	
	result.success = success
	
	return result
		
