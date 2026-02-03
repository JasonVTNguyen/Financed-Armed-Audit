extends Node

var inventory : Inventory
var currentFish : Fish
var total_weight : float = 0.0
var total_bait : int = 3
var primary_gun = Gun.new("Pistol", 5, 5000, 20, 10)
var secondary_gun = Gun.new("Shotgun", 25, 3500, 50,5)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Game Loaded.")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func reset_game():
	inventory = Inventory.new()
	currentFish = Fish.new()
	total_weight = 0.0
	total_bait = 3
