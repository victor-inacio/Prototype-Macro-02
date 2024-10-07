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
	
