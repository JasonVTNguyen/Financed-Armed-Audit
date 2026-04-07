extends Node

@onready var screen_size = get_viewport().get_visible_rect().size

var inventory : Inventory = Inventory.new()
var currentFish : Fish
var total_value : float = 0.0
var money : float = 0.0
var total_bait : int = 3
var current_round : int = 0
var rounds_fish_caught : Array[Fish] = []
var money_at_beginning : float = 0.0
var number_of_shots : int = 0
var fishing_qte_score : float
var tutorial_on : bool = true

var current_bait : int = 3
var primary_gun : Gun
var primary_gun_upgrades : Array[Upgrade] = []

var secondary_gun : Gun
var secondary_gun_upgrades : Array[Upgrade] = []

var current_hook : Hook
var current_rod : FishingRod

var story_round_objectives : Dictionary[int,float] = {
	0 : 10.0,
	1 : 50.0,
	2 : 100.0,
	3 : 200.0,
	4 : 500.0,
	5 : 1250.0,
	6 : 5000.0,
	7 : 10000.0,
	8 : 25000.0,
	9 : 50000.0,
}

enum GunState {HIT, MISS}

var gun_state : GunState = GunState.MISS

func _ready() -> void:
	print("Game Loaded.")
	print(RenderingServer.get_video_adapter_name())
	#print(get_viewport().get_visible_rect().size[0])

func reset_game():
	inventory = Inventory.new()
	currentFish = Fish.new()
	total_value = 0.0
	money = 9990.0
	total_bait = 3
	current_bait = 3
	current_round = 0
	primary_gun = Catalogue.weapons.get(0)
	primary_gun_upgrades = []
	secondary_gun = Catalogue.weapons.get(1)
	secondary_gun_upgrades = []
	current_hook = Catalogue.hooks.get(0)
	current_rod = Catalogue.rods.get(0)
	rounds_fish_caught = []
	money_at_beginning = 0.0
	number_of_shots = 0
	tutorial_on = true
	
func start_game():
	reset_game()
	get_tree().change_scene_to_file("res://game/scenes/fishing/fishing.tscn")

func play_bgm(bgm):
	$"BGM Test".play()
