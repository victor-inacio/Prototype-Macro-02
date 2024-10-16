class_name ScheduledAction extends Node

var action: Action
var action_result: ActionResult
var rounds_to_wait: int = 0
var rounds_passed: int = 0

func _init(action: Action, action_result: ActionResult, rounds_to_wait: int):
	self.action = action
	self.action_result = action_result
	self.rounds_to_wait = rounds_to_wait

func rounds_left() -> int:
	return rounds_to_wait - rounds_passed
	
func increase_round():
	rounds_passed += 1
