class_name DamageIncrease extends Ability

var damage_increase: int = 0

func _init(increase: int):
	self.is_temporary = true
	self.rounds_left = 1
	self.damage_increase = increase
