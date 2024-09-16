class_name Enemy extends Character

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func play(player: Player):
	var rand_integer = randi_range(0, 3)
	
	if (rand_integer == Mode.ITEM):
		play(player)
		return
	
	
	
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
	
	_post_play(rand_integer)
	

