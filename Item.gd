class_name Item extends Action

enum Type {
	NUMBER,
	PERCENTAGE
}

@export
var ilimited: bool = false

@export
var quantity: int = 1

@export
var life_increase_type: Type = Type.NUMBER

@export 
var life_increase: int = 0

@export
var stamina_increase_type: Type = Type.NUMBER

@export
var stamina_increase: int

@export
var damage_increase_type: Type = Type.NUMBER

@export
var damage_increase: int

func get_result(user: Character, target: Character) -> ItemResult:
	var result: ItemResult = ItemResult.new()
	
	result.damage_increase = damage_increase if damage_increase_type == Type.NUMBER else (float)(damage_increase) / 100 * user.damage 
	result.stamina_increase = stamina_increase if stamina_increase_type == Type.NUMBER else (float)(stamina_increase) / 100 * user.max_stamina 
	result.life_increase = life_increase if life_increase_type == Type.NUMBER else (float)(life_increase) / 100 * user.max_life 
	_setup_result(result)
	print((float)(life_increase) / 100)

	return result	
	
func formatted_str():
	var quantity_str: String = "inf" if ilimited else "%dx" % [quantity]
	return "%s (%s)" % [name, quantity_str]

func equals(action: Action) -> bool:
	return life_increase_type == action.life_increase_type and life_increase == action.life_increase and stamina_increase_type == action.stamina_increase_type and stamina_increase == action.stamina_increase and damage_increase_type == action.damage_increase_type and damage_increase == action.damage_increase
