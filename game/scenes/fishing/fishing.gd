extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"Bait Count".text = str(GameController.total_bait)
	$"Total Weight".text = str(GameController.total_weight)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func makeFish():
	print("Making Fish")
	var new_fish = Fish.new("Salmon", 35.0, 50.0)
	GameController.total_bait -= 1
	print(new_fish)
	GameController.currentFish = new_fish
	get_tree().change_scene_to_file("res://game/scenes/shooting/shooting_phase.tscn")
