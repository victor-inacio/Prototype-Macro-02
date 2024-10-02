extends Node2D

class_name FightManager

enum Chars {
	Player, Enemy
}

signal fighter_changed
signal toggle_turned

@export 
var player: Player

@export
var enemy: Enemy

var action_queue = {
	'player': {
		'action': null,
		'rounds_to_wait': 0
	},
	'enemy': {
		'action': null,
		'rounds_to_wait': 0
	}
}	

var enemy_enqueued_action: AttackResult

var current_fighter: Character:
	set(val):
		current_fighter = val
		fighter_changed.emit(val)
		_handle_fighter_changed(val)
		
		
func start(curr_fighter: Character):
	current_fighter = curr_fighter
		
func _handle_fighter_changed(val: Character):
	if (val is Player):
		pass
	else:
		var queue = action_queue['enemy']['rounds_to_wait']
		
		if (queue > 0):
			action_queue['enemy']['rounds_to_wait'] -= 1
			_toggle_turn()
			return
		
		var action: AttackResult = enemy.play(player) if action_queue['enemy']['action'] == null else action_queue['enemy']['action']
		
		if (action.isEnqueued):
			if (action_queue['enemy']['action'] == null):
				action_queue['enemy']['rounds_to_wait'] = action.roundsToWait
				action_queue['enemy']['action'] = action
				_toggle_turn()
				return
			
				
			
		var damage = action.damageGiven
		
		player.life -= damage
	
	
	
	

func _enqueue_action(target: String, action: AttackResult):
	action_queue[target]['action'] = action
	action_queue[target]['rounds_to_wait'] = action.roundsToWait
	
	
func _toggle_turn():

	var last_fighter = current_fighter
	
	if (last_fighter.life <= 0):
		if (last_fighter is Player):
			get_tree().change_scene_to_file("res://lose.tscn")
		else:
			get_tree().change_scene_to_file("res://won.tscn")
			
	
	if (current_fighter is Player):
		current_fighter = enemy
	else:
		current_fighter = player
	toggle_turned.emit(last_fighter)
	
func _handle_character_play(character: Character):
	await get_tree().create_timer(1).timeout
	
	if (character is Player):
		character.stamina += 5
	
	_toggle_turn()
	
func _on_player_played(player: Player):
	_handle_character_play(player)

func _on_enemy_played(enemy: Enemy):
	_handle_character_play(enemy)
