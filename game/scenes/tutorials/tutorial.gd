extends Node
class_name Tutorial

@export var tutorial_id : String
@export var tutorial_title_str : String
@export var tutorial_text_str : String
@export var tutorial_image_str : String

func _init(c_id, c_title, c_text, c_img = "res://icon.svg") -> void:
	tutorial_id = c_id
	tutorial_title_str = c_title
	tutorial_text_str = c_text
	tutorial_image_str = c_img
