extends Node

@export var tutorial_id : String
@export var tutorial_title: Label
@export var tutorial_text: Label
@export var tutorial_image: Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
func set_tutorial_text(title, text, texture) -> void:
	tutorial_title.text = title
	tutorial_text.text = text
	tutorial_image.texture = load(texture)

func type_tutorial_text(speed : float = 0.01):
	var text = tutorial_text.text
	tutorial_text.visible_characters = 0
	for i in range(text.length()):
		tutorial_text.visible_characters += 1
		await get_tree().create_timer(speed).timeout
