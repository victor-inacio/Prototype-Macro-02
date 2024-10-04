class_name Enemy extends Character

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func play(player: Player) -> ActionResult:
	var actions: Array[Action] = []
	
	for attack in self.attacks:
		actions.append(attack)
	
	for item in self.items:
		actions.append(item)
	
	
	var rand_integer = randi_range(0, len(actions) - 1)		
	
	var action = actions[rand_integer]
	
	var index = 0
	if (action is Item):
		for item in items:
			if (item.equals(action)):
				items.remove_at(index)
			index += 1
	
	var result = action.get_result(self, player) 
	
	_post_play(action)
	return result
		

	match (rand_integer):
		Mode.ATTACK:
			var damage = 10
			player.take_damage(self, damage)
		Mode.ITEM:
			var life_plus = 10
			life += life_plus
		Mode.DODGE:
			var tween = create_tween()
		Mode.SKILL:
			var damage = 10
			player.take_damage(self, damage)
			pass
	
	
	

