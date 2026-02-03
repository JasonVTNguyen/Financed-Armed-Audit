extends Sprite2D

class_name Target_Fish

var target_max_health : int
var target_cur_health : int

func _init(c_target_max_health : int = 200) -> void:
	target_max_health = c_target_max_health
	target_cur_health = c_target_max_health

func damage_target(damage) -> void:
	target_cur_health -= damage
	if target_cur_health <= 0:
		print("target is dead.")
