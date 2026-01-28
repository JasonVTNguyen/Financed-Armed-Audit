extends Node2D

var primary_gun = Gun.new("Pistol", 5)
var times_shot = 0

func _ready() -> void:
	print(primary_gun)

func _on_target_area_target_shot() -> void:
	times_shot += 1
	$"DPS Label".text = "You have shot the target " + str(times_shot) + " times."
