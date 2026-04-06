extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _on_menu_button_item_selected(index: int) -> void:
	match index:
		0:
			print("Fullscreen")
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		1:
			print("Windowed")
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_back_to_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://game/scenes/mainmenu/main_menu.tscn")
