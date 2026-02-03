extends Sprite2D

class_name Gun

var gun_name : String
var damage : int 
var cap_ammo : int
var max_ammo : int
var cur_ammo : int
var mag_size : int

func _process(delta: float) -> void:
	position = get_viewport().get_mouse_position()

func _init(c_gun_name : String = "Test Gun", c_damage : int = 0, c_cap_ammo : int = 999999999, c_max_ammo : int = 999999999, c_mag_size : int = 10) -> void:
	gun_name = c_gun_name
	damage = c_damage
	cap_ammo = c_cap_ammo
	max_ammo = c_max_ammo
	cur_ammo = c_mag_size
	mag_size = c_mag_size
	
	
func check_can_fire_gun():
	if cur_ammo > 0:
		return true
	return false

func check_no_more_ammo():
	if max_ammo <= 0 and cur_ammo <= 0:
		return true
	return false

func reload_calculation() -> int:
	var used_ammo = mag_size - cur_ammo
	if used_ammo <= max_ammo:
		return used_ammo
	else:
		return max_ammo
	
	
func fire_gun():
	if check_can_fire_gun():
		cur_ammo -= 1
	
func reload_gun():
	var give_ammo = reload_calculation()
	max_ammo -= give_ammo
	cur_ammo += give_ammo
	


func _to_string() -> String:
	return "Gun Name: " + gun_name + ", Damage: " + str(damage)
