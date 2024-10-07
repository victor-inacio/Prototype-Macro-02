class_name Action extends Resource

@export
var name: String = "Item Name"

@export_range(0, 100)
var execution_time: int = 0

func get_result(user: Character, target: Character) -> ActionResult:
	return ActionResult.new()
	
func _setup_result(result: ActionResult):
	var isEnqueued: bool = execution_time != 0
	var roundsToWait: int = execution_time
	var already_waited = false
	
	result.isEnqueued = isEnqueued
	result.roundsToWait = roundsToWait
	result.already_waited = false
	
func equals(action: Action) -> bool:
	return false
	
	
