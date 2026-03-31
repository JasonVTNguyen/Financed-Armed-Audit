extends RigidBody2D

class_name Target_Fish

@onready var shooting_phase : Node2D = get_parent()

var target_max_health : int
var target_cur_health : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.apply_impulse(Vector2(150,-550))
	self.gravity_scale = 0.3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _init(c_target_max_health : int = 200) -> void:
	target_max_health = c_target_max_health
	target_cur_health = c_target_max_health

func damage_target(damage) -> void:
	target_cur_health -= damage
	if target_cur_health <= 0:
		print("target is dead.")

var push_direction

func target_hit():
	push_direction = (self.position.x - GameController.screen_size[0] / 2) * -0.5
	self.apply_impulse(Vector2(push_direction,-350))

	
func _on_boundary_areas_area_entered(area: Area2D) -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if GameController.current_bait >= 1:
		get_tree().change_scene_to_file("res://game/scenes/fishing/fishing.tscn")
	else:
		print("Total Value: " + str(GameController.money))
		print("Round Goal: " + str(GameController.story_round_objectives.get(GameController.current_round)))
		get_tree().change_scene_to_file("res://game/scenes/results/results_screen.tscn")
