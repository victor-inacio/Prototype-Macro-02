extends Control

class_name UIManager

@onready
var item_list: ItemList = $MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/VBoxContainer/ItemList
@onready
var texter: ItemList = $MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/VBoxContainer/Texter
@onready
var enemy_health_bar: ProgressBar = $Control/EnemyHealthBar
@onready
var player_health_bar: ProgressBar = $MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/HBoxContainer/PlayerLife
@onready
var player_stamina_bar: ProgressBar = $MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/HBoxContainer/PlayerStamina

var all_buttons: Array[Button]

@export
var fight_manager: FightManager
var mode: Character.Mode

var attacks = [
		"Espada de Madeira (10 Dano, -10 Stamina)",
		"Samuel (10 Dano, -10 Stamina)",
]

var skills = [
		"Atirar com Shotgun (15 Dano, -20 Stamina)"
]

var items = [
	"Biscoito Negrito (+10 HP)",
	"Monster (+10 Stamina)",
	"Soco Ingles (+10 de Dano por 2 Turnos) 1x"
]

var dodges = [
	"Esquivar (Nao leva dano caso ele ataque)"
]

func _ready():
	_clear_item_list()
	all_buttons = [
		$MarginContainer/VBoxContainer/HBoxContainer2/HBoxContainer/VBoxContainer/AttackButton,
		$MarginContainer/VBoxContainer/HBoxContainer2/HBoxContainer/VBoxContainer/SkillButton,
		$MarginContainer/VBoxContainer/HBoxContainer2/HBoxContainer/VBoxContainer/ItensButton,
		$MarginContainer/VBoxContainer/HBoxContainer2/HBoxContainer/VBoxContainer/DodgeButton,
	]
	
	
	
	fight_manager.start(fight_manager.enemy)
	
func _process(delta):
	pass

func _on_attack_button_pressed():
	_clear_item_list()
	item_list.visible = true
	mode = Character.Mode.ATTACK
	fight_manager.player.play(mode, "", fight_manager.enemy)
	


func _on_skill_button_pressed():
	_clear_item_list()
	item_list.visible = true
	#texter.visible = false
	for attack in skills:
		item_list.add_item(attack)
	mode = Character.Mode.SKILL


func _on_itens_button_pressed():
	_clear_item_list()
	item_list.visible = true
	#texter.visible = false
	for attack in items:
		item_list.add_item(attack)
	mode = Character.Mode.ITEM


func _on_dodge_button_pressed():
	_clear_item_list()
	item_list.visible = true
	#texter.visible = false
	for attack in dodges:
		item_list.add_item(attack)
	mode = Character.Mode.DODGE
	
	
func _clear_item_list():
	if (item_list != null):
		item_list.clear()



func _on_item_list_item_clicked(index, at_position, mouse_button_index):
	var item: String 
	var player = fight_manager.player
	var enemy = fight_manager.enemy
	match (mode):
		Character.Mode.ATTACK:
			item = attacks[index]
		Character.Mode.ITEM:
			item = items[index]
			items.remove_at(index)
		Character.Mode.DODGE:
			item = dodges[index]
		Character.Mode.SKILL:
			item = skills[index]
			
	player.play(mode, item, enemy)
		
			
func _on_enemy_life_changed(health):
	if (enemy_health_bar != null):
		var tween = create_tween()
		tween.tween_property(enemy_health_bar, "value", health, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	
		await tween.finished


func _disable_all():
	_clear_item_list()
	for button in all_buttons:
		button.disabled = true	
		
func _enable_all():
	_clear_item_list()
	for button in all_buttons:
		button.disabled = false
	

func _on_fight_manager_fighter_changed(currFighter: Character):
	if (currFighter is Player):
		_enable_all()
	else:
		_disable_all()
		
func _on_player_life_changed(life: int):
	var tween = create_tween()
	tween.tween_property(player_health_bar, "value", life, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	
	await tween.finished


func _on_player_stamina_changed(stamina: int):
	print("STAMINACHANGED")
	var tween = create_tween()
	tween.tween_property(player_stamina_bar, "value", stamina, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	
	await tween.finished


func _on_fight_manager_toggle_turned(last_char: Character):
	pass
		

	#item_list.visible = false
	##texter.visible = true
	#texter.text =   + " " + last_char.last_movement_txt
	
	

func _on_enemy_dodged(enemy: Enemy):
	var enemyN = $Enemy
	var curr_pos = enemy.position
	var tween = create_tween()
	tween.tween_property(enemyN, "position", curr_pos - Vector2(300, 0), 0.5)
	tween.tween_property(enemyN, "position", curr_pos, 0.5)
	await tween.finished


func _on_player_not_enough_stamina():
	var tween = create_tween()
	var curr_pos = player_stamina_bar.global_position
	for i in range(0, 10):
		var dir = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
		var force = 10
		tween.tween_property(player_stamina_bar, "global_position", curr_pos + dir * force, 0.01)
	tween.tween_property(player_stamina_bar, "global_position", curr_pos, 0.000001)	
	await tween.finished
	
func _add_to_texter(text: String):
	var texter_count = texter.item_count
	texter.mouse_force_pass_scroll_events
	texter.add_item(text)
	texter.select(texter_count)
	
	if (texter_count > 4):
		for i in range(0, 2):
			texter.remove_item(i)
	
	
func _on_player_on_action(action: String):
	_add_to_texter(action)
	_disable_all()
	
func _on_enemy_on_action(action: String):
	_add_to_texter(action)
	_disable_all()
	
