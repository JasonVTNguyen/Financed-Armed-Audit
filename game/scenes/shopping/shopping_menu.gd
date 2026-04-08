extends Control

var tutorial : PackedScene = preload("res://game/scenes/tutorials/tutorial_manager.tscn")

var for_sale_weapon : Gun
var for_sale_item1 : Item
var item1_price : float
var for_sale_item2 : Item
var item2_price : float
var for_sale_item3 : Item
var item3_price : float
var for_sale_item4 : Item
var item4_price : float
var buyable_rod : FishingRod = Catalogue.rods.get(0)
var has_bought_something : bool = false

@onready var blacksmith: Control = $Blacksmith
@onready var shop: Control = $Shop
@onready var inventory: Inventory = $Inventory

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if GameController.tutorial_on == GameController.TutorialState.SHOPPING:
		var shoptutorial = tutorial.instantiate()
		add_child(shoptutorial)
		shoptutorial.set_tutorial_deck("ShoppingTutorial")
	
	blacksmith.hide()
	inventory.hide()
	for_sale_weapon = Catalogue.weapons.get(randi_range(0,len(Catalogue.weapons)-1))
	for_sale_item1 = Catalogue.items.get(randi_range(0,len(Catalogue.items)-1))
	for_sale_item2 = Catalogue.items.get(randi_range(0,len(Catalogue.items)-1))
	for_sale_item3 = Catalogue.items.get(randi_range(0,len(Catalogue.items)-1))
	for_sale_item4 = Catalogue.items.get(randi_range(0,len(Catalogue.items)-1))
	
	item1_price = flucuate_costs(for_sale_item1.avg_price)
	item2_price = flucuate_costs(for_sale_item2.avg_price)
	item3_price = flucuate_costs(for_sale_item3.avg_price)
	item4_price = flucuate_costs(for_sale_item4.avg_price)
	
	has_bought_something = false
	
	check_buyables()
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	check_buyables()

func _on_shop_switch_scene() -> void:
	blacksmith.show()
	inventory.hide()
	shop.hide()

func _on_blacksmith_switch_scene() -> void:
	blacksmith.hide()
	inventory.hide()
	shop.show()

func _on_inventory_button_pressed() -> void:
	print(GameController.inventory.items)
	inventory.update_labels()
	inventory.show()

func _on_inventory_close_inventory() -> void:
	inventory.hide()

func flucuate_costs(cost : float) -> float:
	return round(randf_range(cost * .95, cost * 1.05))
	
func check_buyables() -> void:
	if GameController.current_rod == Catalogue.rods.get(0):
		buyable_rod = Catalogue.rods.get(1)
	elif GameController.current_rod == Catalogue.rods.get(1):
		buyable_rod = Catalogue.rods.get(2)
	else:
		buyable_rod = null

func randomize_shopkeeper_dialogue():
	pass
