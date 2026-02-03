extends Node2D

class_name Fish

var fish_name : String
var weight : float
var health : float
var img : String
var lore : String

func _init(c_fish_name : String = "Test Fish", c_weight : float = 250.0, c_health : float = 125.0, c_img : String = "Undefined", c_lore : String = "This is a test fish") -> void:
	fish_name = c_fish_name
	weight = c_weight
	health = c_health
	img = c_img
	lore = c_lore

func _to_string() -> String:
	return fish_name +": Weight: " + str(weight) + " Health: " + str(health)
