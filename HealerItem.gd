extends Item

func _init():
	name = "Biscoito Negrito"

func use(character: Character):
	
	character.life += 10
