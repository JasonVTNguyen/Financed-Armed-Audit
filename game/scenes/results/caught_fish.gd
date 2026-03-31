extends AspectRatioContainer

class_name Caught_Fish

const caught_fish : PackedScene = preload("res://game/scenes/results/caught_fish.tscn")

var f_name : String
var f_value : float

@onready var fish_name: Label = $"Fish Name"
@onready var fish_value: Label = $"Fish Value"


# Called when the node enters the scene tree for the first time.
func update_labels() -> void:
	fish_name.text = f_name
	fish_value.text = "$%.2f" % f_value
	if f_value < 0.0:
		fish_value.set("theme_override_colors/font_color", Color.RED)

static func new_fish(c_name : String, c_value : float) -> Caught_Fish:
	var new_fish : Caught_Fish = caught_fish.instantiate()
	new_fish.f_name = c_name
	new_fish.f_value = c_value
	return new_fish
