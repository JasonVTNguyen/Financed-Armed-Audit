extends Node2D

var fish_scene : PackedScene = preload("res://game/scenes/fishing/fish.tscn")
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	$"Bait Count".text = str(GameController.current_bait)
	$"Total Weight".text = str(GameController.total_weight)
	for i in range(5):
		spawn_fish()

func _process(delta: float) -> void:
	pass

func spawn_fish():
	var spawned_fish = fish_scene.instantiate()
	add_child(spawned_fish)

func makeFish():
	print("Making Fish")
	var new_fish = Fish.new("Salmon", 35.0, 50.0)
	GameController.current_bait -= 1
	print(new_fish)
	GameController.currentFish = new_fish
	get_tree().change_scene_to_file("res://game/scenes/shooting/shooting_phase.tscn")
