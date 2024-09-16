class_name Player extends Character

signal not_enough_stamina

var buffed: int = 0:
	set(val):
		buffed = val
		if (val < 0):
			buffed = 0

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass
	
func play(mode: Mode, what: String, enemy: Character):
	match (mode):
		Mode.ATTACK:
			var stamina_to_use = 10
			if (stamina - stamina_to_use <= 0):
				not_enough_stamina.emit()
				return		
			var damage = 10
			if (buffed > 0):
				damage += 10
				buffed -= 1
			enemy.take_damage(self, damage)
			stamina -= 10
		Mode.ITEM:
			match (what):
				"Monster (+10 Stamina)":
					stamina += 10
				"Biscoito Negrito (+10 HP)":
					life += 10
				"Soco Ingles (+10 de Dano por 2 Turnos) 1x":
					on_action.emit("%s usou %s" % [name, "Soco Ingles (+10 de Dano por 2 Turnos)"])
					buffed = 2
		Mode.DODGE:
			pass
		Mode.SKILL:
			var stamina_to_use = 20
			if (stamina - stamina_to_use <= 0):
				not_enough_stamina.emit()
				return
			var damage = 15
			if (buffed > 0):
				damage += 10
				buffed -= 1
			enemy.take_damage(self, damage)
			stamina -= 20
			
	
	_post_play(mode)	
