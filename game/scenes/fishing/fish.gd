extends Sprite2D

class_name Fish

var rng = RandomNumberGenerator.new()
var screen_size = Vector2(1152,648)
var r_x = rng.randi_range(0, screen_size.x)
var r_y = rng.randi_range(0, screen_size.y)


var fish_name : String
var weight : float
var health : float
var img : String
var lore : String

func _init(c_fish_name : String = "Test Fish", c_weight : float = 250.0, c_health : float = 125.0, c_img : String = "res://icon.svg", c_lore : String = "This is a test fish") -> void:
	fish_name = c_fish_name
	weight = c_weight
	health = c_health
	img = c_img
	lore = c_lore
	self.position = Vector2(r_x, r_y)

func _ready() -> void:
	print()


func _to_string() -> String:
	return fish_name +": Weight: " + str(weight) + " Health: " + str(health)
