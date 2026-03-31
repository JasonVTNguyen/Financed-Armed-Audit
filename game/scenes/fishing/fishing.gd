extends Node2D

var fish_scene : PackedScene = preload("res://game/scenes/fishing/fish.tscn")
var fishing_qte : PackedScene = preload("res://game/scenes/fishing/fishing_qte.tscn")

var bobber_location : Vector2
@onready var fish_move_area : NavigationRegion2D = $"Fish Move Area"

enum BobberState {SET, NOT_SET}


var bobber_state = BobberState.NOT_SET


var is_qte : bool = false

func _ready() -> void:
	#print("Fishing Scene Ready")
	$"Bait Count".text = str(GameController.current_bait)
	$"Total Value".text = "%.2f" % GameController.money
	$"Required Weight Total".text = "%.2f" % GameController.story_round_objectives.get(GameController.current_round)
	for i in range(5):
		spawn_fish()
	GameController.fishing_qte_score = 0
	is_qte = false
	
func _process(delta: float) -> void:
	pass

func spawn_fish():
	var spawned_fish = fish_scene.instantiate()
	randomize_fish(spawned_fish)
	add_child(spawned_fish)

func randomize_fish(new_fish : Fish) -> void:
	var random_fish : Fish = $"Fish Dictionary".fishtionary[randi_range(1, $"Fish Dictionary".fishtionary.size())]
	new_fish.fish_name = random_fish.fish_name
	new_fish.value = random_fish.value
	new_fish.health = random_fish.health
	new_fish.img = random_fish.img
	new_fish.lore = random_fish.lore
	new_fish.fish_size = random_fish.fish_size
	
func makeFish(fish):
	if bobber_state == BobberState.SET and not is_qte:
		#print("Making Fish")
		GameController.current_bait -= 1
		GameController.currentFish = Fish.new(fish.fish_name, fish.value, fish.health, fish.img, fish.lore)
		add_child(fishing_qte.instantiate())
		bobber_state = BobberState.NOT_SET
		is_qte = true


func set_bobber(bobber_pos) -> void:
	bobber_location = bobber_pos
	bobber_state = BobberState.SET
	#print(bobber_location)

func unset_bobber() -> void:
	bobber_state = BobberState.NOT_SET

func _on_skip_to_shop_button_pressed() -> void:
	get_tree().change_scene_to_file("res://game/scenes/shopping/shopping_menu.tscn")
