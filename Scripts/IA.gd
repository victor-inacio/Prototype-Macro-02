class_name IA

func decide_action(character: Character, target: Character) -> Action:
	var actions: Array[Action] = character.get_all_actions()
	
	var rand_integer = randi_range(0, len(actions) - 1)
	var action = actions[rand_integer]
	
	print(action.name)
	
	return action
