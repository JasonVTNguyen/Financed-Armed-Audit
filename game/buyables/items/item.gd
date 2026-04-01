extends Resource

class_name Item

enum Item_Type {ITEM, SHOOTING, FISHING, VALUE}

var item_name : String
var item_type : Item_Type
var item_texture : Texture
var item_desc : String
var avg_price : float

var function_text : String

var flat_value : int = 0
var percent_value : float = 1.0

var item_function_flat : String
var item_function_percent : String
var item_condition_value : float
var item_modifier_value : float

func _init(c_item_name : String, c_item_type : String, c_item_desc : String, c_function_text : String, c_price : float, c_flat : int = 0, c_percent : float = 1.0, c_func_f : String = "", c_func_p : String = "", c_cond_value : float = 1.0, c_mod_v : float = 1.0) -> void:
	item_name = c_item_name
	match c_item_type:
		"ITEM":
			item_type = Item_Type.ITEM
		"SHOOTING":
			item_type = Item_Type.SHOOTING
		"FISHING":
			item_type = Item_Type.FISHING
		"VALUE":
			item_type = Item_Type.VALUE
		
	item_desc = c_item_desc
	function_text = c_function_text
	avg_price = c_price
	flat_value = c_flat
	percent_value = c_percent
	item_function_flat = c_func_f
	item_function_percent = c_func_p
	item_condition_value = c_cond_value
	item_modifier_value = c_mod_v
	
func apply_conditional_flat():
	match item_function_flat:
		"":
			return flat_value
		"bait_multiplier":
			return FunctionLibrary.bait_multiplier_func(flat_value)
		
func apply_conditional_percent():
	match item_function_percent:
		"":
			return percent_value
		"shot_based":
					return FunctionLibrary.shot_based_damage(percent_value, item_condition_value, item_modifier_value)

func _to_string() -> String:
	return "Item Name: " + item_name + ", Description: " + item_desc
