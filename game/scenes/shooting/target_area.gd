extends Area2D

@onready var shooting_phase : Node2D = get_parent().get_parent()
@onready var target_fish: RigidBody2D = $".."

var push_direction

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	push_direction = (target_fish.position.x - get_viewport().get_visible_rect().size[0] / 2) * -0.5
	if event.is_action_pressed("Shoot"):
		if shooting_phase.update_damage():
			target_fish.apply_impulse(Vector2(push_direction,-250))
		# print("target hit!")
