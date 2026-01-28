extends Node2D

var primary_gun = Gun.new("Pistol", 5)
var new_target = Target.new()
var total_damage = 0

signal target_damaged

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$"Fish Health".text = str(new_target.target_cur_health) + " / " + str(new_target.target_max_health)
	print(primary_gun)

func _on_target_area_target_shot() -> void:
	total_damage += primary_gun.damage
	new_target.damage_target(primary_gun.damage)
	$"DPS Label".text = "You have done " + str(total_damage)+ " damage."
	$"Fish Health".text = str(new_target.target_cur_health) + " / " + str(new_target.target_max_health)
