extends Node2D

var fish_scene : PackedScene = preload("res://game/scenes/fishing/fish.tscn")
var fishing_qte : PackedScene = preload("res://game/scenes/fishing/fishing_qte.tscn")
var tutorial : PackedScene = preload("res://game/scenes/tutorials/tutorial_manager.tscn")

@onready var inventory: Inventory = $Inventory

var inv_opened : bool = false

var bobber_location : Vector2
@onready var fish_move_area : NavigationRegion2D = $"Fish Move Area"

enum BobberState {SET, NOT_SET}
enum MouseState {IN,OUT}
var mouse_state = MouseState.OUT
var bobber_state = BobberState.NOT_SET


var is_qte : bool = false

func _ready() -> void:
	#print("Fishing Scene Ready")
	$"Bait Count".text = "x %d" % GameController.current_bait
	$"Total Value".text = "$%.2f" % GameController.money
	$BGM.play()
	print(auto_scientific(GameController.money))
	var auto_sci_objective = auto_scientific(GameController.story_round_objectives.get(GameController.current_round))
	$"Required Total".text = "/ $" + auto_sci_objective
	for i in range(5):
		spawn_fish()
	GameController.fishing_qte_score = 0
	is_qte = false
	if GameController.tutorial_on:
		add_child(tutorial.instantiate())
	
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

func check_if_can_place_bobber() -> bool:
	if not inv_opened:
		match mouse_state:
			MouseState.IN:
				return true
			MouseState.OUT:
				return false
	return false

func set_bobber(bobber_pos) -> void:
	if not inv_opened and check_if_can_place_bobber():
		bobber_location = bobber_pos
		bobber_state = BobberState.SET
		#print(bobber_location)

func unset_bobber() -> void:
	bobber_state = BobberState.NOT_SET

func _on_skip_to_shop_button_pressed() -> void:
	get_tree().change_scene_to_file("res://game/scenes/shopping/shopping_menu.tscn")


func _on_open_inventory_button_pressed() -> void:
	if bobber_state == BobberState.NOT_SET:
		print(GameController.inventory.items)
		inventory.update_labels()
		inventory.show()
	inv_opened = true

func _on_inventory_close_inventory() -> void:
	inventory.hide()
	inv_opened = false


func _on_lake_boundaries_mouse_entered() -> void:
	mouse_state = MouseState.OUT


func _on_lake_boundaries_mouse_exited() -> void:
	mouse_state = MouseState.IN

func auto_scientific(number : float) -> String:
	var tens = log(number) / log(10)
	if tens >= 3 and tens < 6:
		return str(number/1000.0) + "K"
	elif tens >= 6:
		return str(number/1000000.0) + "M"
	return str(number)
