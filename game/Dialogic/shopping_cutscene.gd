extends Node

func _ready() -> void:
	Dialogic.start("res://game/Dialogic/timelines/shoppingtutorial.dtl")
	
func _on_skip_cutscene_button_pressed() -> void:
	Dialogic.end_timeline()
	get_tree().change_scene_to_file("res://game/scenes/shopping/shopping_menu.tscn")
