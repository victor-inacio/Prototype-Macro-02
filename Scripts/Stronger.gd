extends Skill

var turn_count = 2

func _init():
	name = "Xerequinha"
	
func activate(on: Character):
	turn_count -= 1
	
	if turn_count == 0:
		
	
