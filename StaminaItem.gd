extends Item

func _init():
	name = "Monster"

func use(character: Character): 
	character.stamina += 10
