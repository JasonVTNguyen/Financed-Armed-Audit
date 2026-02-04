extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	GameController.current_bait = GameController.total_bait
	get_tree().change_scene_to_file("res://game/scenes/fishing/fishing.tscn")
