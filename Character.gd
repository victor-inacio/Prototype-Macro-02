extends Node

class_name Character

var stamina: int = 100:
	set(val):
		if (val > stamina):
			on_action.emit("%s recuperou %d de stamina" % [name, val - life])
		stamina = val
		if (val > 100):
			stamina = 100
		if (val < 0):
			stamina = 0
		stamina_changed.emit(stamina)

signal stamina_changed
signal on_action


enum Mode {
	ATTACK, SKILL, ITEM, DODGE
}

signal life_changed
signal played
signal dodged

var last_movement: Mode
var last_movement_txt: String = "TESTE"

var life: int = 100: 
	set(val):
		if (val > life):
			on_action.emit("%s curou %d de vida" % [name, val - life])
		
		life = val
		if (val > 100):
			life = 100
		if (val < 0):
			life = 0
	
		life_changed.emit(life)

		
# TAKE DAMAGE, HEAL, CAUSED DAMAGE, STAMINA, DODGED
func take_damage(from: Character, damage: int):
	if (last_movement == Mode.DODGE):
		dodged.emit(self)
		on_action.emit(name + " esquivou do ataque de " + from.name)
		return
	on_action.emit(from.name + " causou " + str(damage) + " de dano em " + self.name )
	life -= damage
	
func _post_play(movement: Mode):
	last_movement = movement
	self.played.emit(self)

