extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_labels()

func update_labels() -> void:
	match DisplayServer.window_get_mode():
		DisplayServer.WINDOW_MODE_FULLSCREEN:
			$MenuButton.select(0)
		DisplayServer.WINDOW_MODE_WINDOWED:
			$MenuButton.select(1)

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
