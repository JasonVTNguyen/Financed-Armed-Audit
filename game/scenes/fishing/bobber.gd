extends Sprite2D

@onready var fishing_scene : Node2D = get_parent()

var is_placed : bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_placed:
		var overlapping : Array[Area2D] = $"Attraction Range".get_overlapping_areas()
		for node: Area2D in overlapping:
			node.set_attract_mode()
	if not is_placed:
		var overlapping : Array[Area2D] = $"Attraction Range".get_overlapping_areas()
		for node: Area2D in overlapping:
			node.set_wander_mode()
		position = get_viewport().get_mouse_position()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Select"):
			is_placed = true
			fishing_scene.set_bobber(self.position)
	if event.is_action_pressed("Cancel"):
		if is_placed:
			fishing_scene.unset_bobber()
			is_placed = false


func _on_attraction_range_area_entered(area: Area2D) -> void:
	if is_placed:
		print("Fish Detected at: " + str(area.name))
		area.set_attract_mode()
	pass


func _on_fish_collider_area_entered(area: Area2D) -> void:
	if is_placed:
		print("Fish Touched")
		area.send_fish()
	pass
