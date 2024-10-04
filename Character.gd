extends Node

class_name Character

var stamina: int = 100:
	set(val):
			#on_action.emit("%s recuperou %d de stamina" % [name, val - life])
		stamina = clamp(val, 0, 100)
		stamina_changed.emit(stamina)

@export
var attacks: Array[Attack] = []

@export 
var items: Array[Item] = []

var abilities: Array[Ability] = []

var roundsToWait = 0

signal stamina_changed
signal on_action

signal life_changed
signal played
signal dodged


var last_action: Action
var scheduled_action: ScheduledAction

enum Mode {
	ATTACK, SKILL, ITEM, DODGE
}

var life: int = 100: 
	set(val):
		if (val > life):
			on_action.emit("%s curou %d de vida" % [name, val - life])
		life = clamp(val, 0, 100)
		life_changed.emit(life)

		
# TAKE DAMAGE, HEAL, CAUSED DAMAGE, STAMINA, DODGED
func take_damage(from: Character, damage: int):
	if (last_action is Dodge):
		dodged.emit(self)
		on_action.emit(name + " esquivou do ataque de " + from.name)
		return
	on_action.emit(from.name + " causou " + str(damage) + " de dano em " + self.name )
	life -= damage
	
func _post_play(action: Action):
	last_action = action
	self.played.emit(self)

func decrease_abilities():
	var index = 0
	for ability in abilities:
		if (ability.is_temporary):
			if(ability.rounds_left == 0):
				abilities.remove_at(index)
			ability.rounds_left -= 1
			
		index +=  1

func has_scheduled_action() -> bool:
	return scheduled_action != null

func schedule_action(action: ActionResult, rounds_to_wait: int):
	scheduled_action = ScheduledAction.new(action, rounds_to_wait)
