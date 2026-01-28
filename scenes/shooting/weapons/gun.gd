extends Node2D

class_name Gun

var gun_name : String
var damage : int 


func _init(c_gun_name : String = "Test Gun", c_damage : int = 0) -> void:
	gun_name = c_gun_name
	damage = c_damage
	
func _to_string() -> String:
	return "Gun Name: " + gun_name + ", Damage: " + str(damage)
