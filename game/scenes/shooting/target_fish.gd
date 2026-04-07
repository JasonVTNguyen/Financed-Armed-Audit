extends RigidBody2D

class_name Target_Fish

@onready var shooting_phase : Node2D = get_parent()
@onready var target_sprite: Sprite2D = $TargetSprite


var target_max_health : int
var target_cur_health : int
var target_img : String = "res://icon.svg"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.apply_impulse(Vector2(150,-550))
	self.gravity_scale = 0.3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	rotate(.1)
	

func _init(c_target_max_health : int = 200, c_img : String = "res://icon.svg") -> void:
	target_max_health = c_target_max_health
	target_cur_health = c_target_max_health
	target_img = c_img

func damage_target(damage) -> void:
	target_cur_health -= damage
	if target_cur_health <= 0:
		print("target is dead.")

var push_direction

func sprite_to_polygon() -> void:
	var data = load(target_img).get_data()
	var bitmap = BitMap.new()
	bitmap.create_from_image_alpha(data)
	
	var polys = bitmap.opaque_to_polygons(
		Rect2(Vector2.ZERO, target_sprite.texture.get_size()),
		5
	)
	for poly in polys:
		var collision_polygon = CollisionPolygon2D.new()
		collision_polygon.polygon = poly
		$Area2D.add_child(collision_polygon)
	
func target_hit():
	push_direction = (self.position.x - GameController.screen_size[0] / 2) * -0.5
	self.apply_impulse(Vector2(push_direction,-350))

func change_sprite(img : String) -> void:
	target_sprite.texture = load(img)
	
func _on_boundary_areas_area_entered(area: Area2D) -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if GameController.current_bait >= 1:
		get_tree().change_scene_to_file("res://game/scenes/fishing/fishing.tscn")
	else:
		print("Total Value: " + str(GameController.money))
		print("Round Goal: " + str(GameController.story_round_objectives.get(GameController.current_round)))
		get_tree().change_scene_to_file("res://game/scenes/results/results_screen.tscn")
