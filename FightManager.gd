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

var ia: IA = IA.new()

var enemy_enqueued_action: AttackResult

var current_fighter: Character:
	set(val):
		current_fighter = val
		fighter_changed.emit(val)
		_handle_fighter_changed(val)
		
		
func start(curr_fighter: Character):
	current_fighter = curr_fighter
		
func _handle_fighter_changed(val: Character):
	if (val.has_scheduled_action()):
		var scheduled_action: ScheduledAction = val.scheduled_action

		var rounds_left = scheduled_action.rounds_left()
		
		if (rounds_left == 0):
			var result = scheduled_action.action_result
			val.scheduled_action = null
			result.already_waited = true
			process_action(result, val, enemy if val is Player else player)
		else:
			scheduled_action.increase_round()
			_toggle_turn()
	else:
		if (val is Enemy):
			var action: Action = ia.decide_action(val, player)
			val.play(action, player)
	
		
		
	
	
func process_action(action: ActionResult, fighter: Character, target: Character):
	if (action.isEnqueued && !action.already_waited):
		var time = action.roundsToWait
		fighter.schedule_action(action, time)
		
		_toggle_turn()
		return
	
	if (action is AttackResult):
			
		if (target.last_action is Dodge):
			var succeeded = target.last_action_result.success
			
			if (succeeded):
				target.dodged.emit(target)
				_toggle_turn()
				return
		
		
		var damage = action.damageGiven
		
		var damage_increase = 0
		
		for ability in fighter.abilities:
			if ability is DamageIncrease:
				damage_increase += ability.damage_increase
				
		
		target.life -= damage + damage_increase
			
		
	if (action is ItemResult):
		fighter.life += action.life_increase
		fighter.stamina += action.stamina_increase
		
		if (action.damage_increase != 0):
			var ability = DamageIncrease.new(action.damage_increase)
			fighter.abilities.append(ability)
				
		fighter.decrease_abilities()
		
	_toggle_turn()
	
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
	
func _handle_character_play(character: Character, action: Action, action_result: ActionResult):
	await get_tree().create_timer(1).timeout
	
	process_action(action_result, character, enemy if character is Player else player)
	
	
func _on_player_played(player: Player, action: Action, action_result: ActionResult):
	_handle_character_play(player, action, action_result)
	

func _on_enemy_played(enemy: Enemy, action: Action, action_result: ActionResult):
	_handle_character_play(enemy, action, action_result)
