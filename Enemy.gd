class_name Enemy extends Character

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func play(player: Player) -> AttackResult:
	var rand_integer = randi_range(0, 3)
	
	#if (rand_integer == Mode.ITEM):
		#play(player)
		#return
	
	var index = randi_range(0, len(attacks) - 1)
	var attack = attacks[index]
	var attack_result = attack.get_result()
	
	_post_play(Character.Mode.ATTACK)
	return attack_result
		

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
	
	
	

