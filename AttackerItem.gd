extends Item

func _init():
	name = "Espada de Ferro Encantada"
	
func use(on: Character):
	on.life -= 10
	

