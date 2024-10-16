class_name Player extends Character        

@export
var stamina_per_round: int = 2

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
	
