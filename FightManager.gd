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
		enemy.play(player)
		
	
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
