extends Area2D

signal target_shot

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("Shoot"):
		target_shot.emit()
		print("target hit!")
