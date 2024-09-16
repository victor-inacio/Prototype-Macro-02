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
		await get_tree().create_timer(1).timeout 
		enemy.play(player)
		
	
func _toggle_turn():

	var last_fighter = current_fighter

	if (current_fighter is Player):
		current_fighter = enemy
	else:
		current_fighter = player
	toggle_turned.emit(last_fighter)
	
func _handle_character_play(character: Character):
	await get_tree().create_timer(1).timeout 
	_toggle_turn()
	
	
func _on_player_played(player: Player):
	_handle_character_play(player)


func _on_enemy_played(enemy: Enemy):
	_handle_character_play(enemy)
