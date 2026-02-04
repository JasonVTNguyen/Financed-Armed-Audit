extends RigidBody2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.apply_impulse(Vector2(0,-500))
	self.gravity_scale = 0.3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_boundary_areas_area_entered(area: Area2D) -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene_to_file("res://game/scenes/fishing/fishing.tscn")
