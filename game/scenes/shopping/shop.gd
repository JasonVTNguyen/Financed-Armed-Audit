extends Control

signal switch_scene

@onready var shopping_menu: Control = $".."
@onready var item_name: Label = $VBoxContainer/Name
@onready var description: Label = $VBoxContainer/Description
@onready var function_description: Label = $"VBoxContainer/Function Description"

var bait_price_box : Dictionary[int, float] = {
	1 : 50.0,
	2 : 50.0,
	3 : 50.0,
	4 : 250.0,
	5 : 1000.0,
}

var fishing_rod_price_box : Dictionary[FishingRod, float] = {
	Catalogue.rods.get(1) : 1500,
	Catalogue.rods.get(2) : 5000,
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_values()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_next_round_button_pressed() -> void:
	GameController.current_bait = GameController.total_bait
	GameController.money_at_beginning = GameController.money
	GameController.number_of_shots = 0
	if shopping_menu.has_bought_something:
		description.text = "Thanks for your patronage!"
	else:
		description.text = "Next time, buy something!"
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://game/scenes/fishing/fishing.tscn")

func _on_buy_bait_button_pressed() -> void:
	var bait_cost = bait_price_box.get(GameController.total_bait)
	if GameController.money >= bait_cost:
		GameController.total_bait += 1
		GameController.money -= bait_cost
	else:
		item_name.text = ""
		description.text = "Nice try, stupid. Bring enough money next time."
		function_description.text = ""
	shopping_menu.has_bought_something = true
	update_values()

func buy_item_function(item : Item, cost : float) -> bool:
	if GameController.money >= cost:
		GameController.inventory.add_item(item)
		GameController.money -= cost
		update_values()
		return true
	else:
		item_name.text = ""
		description.text = "Nice try, stupid. Bring enough money next time."
		function_description.text = ""
		return false
	
	
func update_values() -> void:
	$Money.text = "Cash: $%.2f" % GameController.money
	$"Start Next Round Button".text = "Next Installment\n$%.2f" % GameController.story_round_objectives.get(GameController.current_round)

func _on_blacksmith_button_pressed() -> void:
	switch_scene.emit()

func _on_buy_bait_button_mouse_entered() -> void:
	item_name.text = "Bait Upgrade (Costs: $%.2f)" % bait_price_box.get(GameController.total_bait)
	description.text = "Allows you to fish extra fish."

func _on_buy_item_button_1_mouse_entered() -> void:
	item_name.text = str(shopping_menu.for_sale_item1.item_name) + " (Costs: $%.2f)" % shopping_menu.item1_price
	description.text = str(shopping_menu.for_sale_item1.item_desc) 
	function_description.text = str(shopping_menu.for_sale_item1.function_text)

func _on_buy_item_button_1_pressed() -> void:
	if buy_item_function(shopping_menu.for_sale_item1, shopping_menu.item1_price):
		shopping_menu.has_bought_something = true
		$"Buy Item Button 1".queue_free()

func _on_buy_item_button_2_mouse_entered() -> void:
	item_name.text = str(shopping_menu.for_sale_item2.item_name) + " (Costs: $%.2f)" % shopping_menu.item2_price
	description.text = str(shopping_menu.for_sale_item2.item_desc) 
	function_description.text = str(shopping_menu.for_sale_item2.function_text)

func _on_buy_item_button_2_pressed() -> void:
	if buy_item_function(shopping_menu.for_sale_item2, shopping_menu.item2_price):
		shopping_menu.has_bought_something = true
		$"Buy Item Button 2".queue_free()

func _on_buy_item_button_3_mouse_entered() -> void:
	item_name.text = str(shopping_menu.for_sale_item3.item_name) + " (Costs: $%.2f)" % shopping_menu.item3_price
	description.text = str(shopping_menu.for_sale_item3.item_desc) 
	function_description.text = str(shopping_menu.for_sale_item3.function_text)

func _on_buy_item_button_3_pressed() -> void:
	if buy_item_function(shopping_menu.for_sale_item3, shopping_menu.item3_price):
		shopping_menu.has_bought_something = true
		$"Buy Item Button 3".queue_free()

func _on_buy_item_button_4_mouse_entered() -> void:
	item_name.text = str(shopping_menu.for_sale_item4.item_name) + " (Costs: $%.2f)" % shopping_menu.item4_price
	description.text = str(shopping_menu.for_sale_item4.item_desc)
	function_description.text = str(shopping_menu.for_sale_item4.function_text)

func _on_buy_item_button_4_pressed() -> void:
	if buy_item_function(shopping_menu.for_sale_item4, shopping_menu.item4_price):
		shopping_menu.has_bought_something = true
		$"Buy Item Button 4".queue_free()
	
func clear_description() -> void:
	item_name.text = ""
	description.text = ""
	function_description.text = ""
