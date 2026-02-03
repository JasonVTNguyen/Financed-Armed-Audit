extends Area2D

@onready var shooting_phase : Node2D = get_parent().get_parent()


func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("Shoot"):
		shooting_phase.update_damage()
		# print("target hit!")
