class_name Attack extends Action


@export_range(0, 1000)
var damage: int = 10

@export_range(0, 100)
var chance_of_damage: int = 100

@export_range(0, 100)
var execution_time: int = 0

func get_result(user: Character, target: Character) -> AttackResult:
	var result = AttackResult.new()
	var random = randi_range(0, 100)
	
	var failedToHit = chance_of_damage < random
	var isEnqueued = execution_time > 0
	
	result.failedToHit = failedToHit
	result.damageGiven = 0 if failedToHit else damage
	result.isEnqueued = isEnqueued
	result.roundsToWait = 0 if not isEnqueued else execution_time	
	
	return result

func _ready():
	pass

func _process(delta):
	pass
