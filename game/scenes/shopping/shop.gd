extends Control

signal switch_scene

@onready var shopping_menu: Control = $".."
@onready var item_name: Label = $VBoxContainer/Name
@onready var description: Label = $VBoxContainer/Description
@onready var function_description: Label = $"VBoxContainer/Function Description"
@onready var buy_item_button_1: TextureButton = $"Buy Item Button 1"
@onready var buy_item_button_2: TextureButton = $"Buy Item Button 2"
@onready var buy_item_button_3: TextureButton = $"Buy Item Button 3"
@onready var buy_item_button_4: TextureButton = $"Buy Item Button 4"

var is_talking : bool = false

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
	$Shopkeeper.play("idle")
	$Panel.hide()
	update_values()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GameController.total_bait >= 5:
		$"Buy Bait Button".hide()
	if shopping_menu.for_sale_item1 and buy_item_button_1:
		buy_item_button_1.texture_normal = shopping_menu.for_sale_item1.item_texture
	if shopping_menu.for_sale_item2 and buy_item_button_2:
		buy_item_button_2.texture_normal = shopping_menu.for_sale_item2.item_texture
	if shopping_menu.for_sale_item3 and buy_item_button_3:
		buy_item_button_3.texture_normal = shopping_menu.for_sale_item3.item_texture
	if shopping_menu.for_sale_item4 and buy_item_button_4:
		buy_item_button_4.texture_normal = shopping_menu.for_sale_item4.item_texture
	update_values()


func _on_start_next_round_button_pressed() -> void:
	GameController.current_bait = GameController.total_bait
	GameController.money_at_beginning = GameController.money
	GameController.number_of_shots = 0
	if shopping_menu.has_bought_something:
		shopkeeper_dialogue("Thank you for your patronage!","talking-normal","idle")
	else:
		shopkeeper_dialogue("Next time, buy something!","talking-normal","idle")
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://game/scenes/fishing/fishing.tscn")

func _on_buy_bait_button_pressed() -> void:
	var bait_cost = bait_price_box.get(GameController.total_bait)
	if GameController.money >= bait_cost:
		GameController.total_bait += 1
		GameController.money -= bait_cost
		item_name.text = "Bait Upgrade (Costs: $%.2f)" % bait_price_box.get(GameController.total_bait)
		description.text = "Allows you to fish extra fish."
		shopping_menu.has_bought_something = true
	else:
		item_name.text = ""
		shopkeeper_dialogue("Nice try, stupid. Bring enough money next time.","talking-mad","idle-mad")
		function_description.text = ""
	update_values()

func buy_item_function(item : Item, cost : float) -> bool:
	if GameController.money >= cost:
		GameController.inventory.add_item(item)
		GameController.money -= cost
		update_values()
		shopkeeper_dialogue("Thank you for your purchase!","talking-normal","idle")
		return true
	else:
		item_name.text = ""
		shopkeeper_dialogue("Nice try, stupid. Bring enough money next time.","talking-mad","idle-mad")
		function_description.text = ""
		return false


func update_values() -> void:
	$Money.text = "Cash: $%.2f" % GameController.money
	$"Start Next Round Button".text = "Next Installment\n$%.2f" % GameController.story_round_objectives.get(GameController.current_round)
	if not shopping_menu.buyable_rod:
		$"Upgrade Rod Button".queue_free()

func set_item_icon(item) -> void:
	pass

func _on_blacksmith_button_pressed() -> void:
	switch_scene.emit()

func _on_buy_bait_button_mouse_entered() -> void:
	if not is_talking:
		$Panel.show()
		item_name.text = "Bait Upgrade (Costs: $%.2f)" % bait_price_box.get(GameController.total_bait)
		description.text = "Allows you to fish extra fish."

func _on_buy_item_button_1_mouse_entered() -> void:
	if not is_talking:
		$Panel.show()
		item_name.text = "%s (Costs: $%.2f)" % [shopping_menu.for_sale_item1.item_name,shopping_menu.item1_price]
		description.text = str(shopping_menu.for_sale_item1.item_desc) 
		function_description.text = str(shopping_menu.for_sale_item1.function_text)

func _on_buy_item_button_1_pressed() -> void:
	if buy_item_function(shopping_menu.for_sale_item1, shopping_menu.item1_price):
		shopping_menu.has_bought_something = true
		$"Buy Item Button 1".queue_free()

func _on_buy_item_button_2_mouse_entered() -> void:
	if not is_talking:
		$Panel.show()
		item_name.text = "%s (Costs: $%.2f)" % [shopping_menu.for_sale_item2.item_name,shopping_menu.item2_price]
		description.text = str(shopping_menu.for_sale_item2.item_desc) 
		function_description.text = str(shopping_menu.for_sale_item2.function_text)

func _on_buy_item_button_2_pressed() -> void:
	if buy_item_function(shopping_menu.for_sale_item2, shopping_menu.item2_price):
		shopping_menu.has_bought_something = true
		$"Buy Item Button 2".queue_free()

func _on_buy_item_button_3_mouse_entered() -> void:
	if not is_talking:
		$Panel.show()
		item_name.text = "%s (Costs: $%.2f)" % [shopping_menu.for_sale_item3.item_name,shopping_menu.item3_price]
		description.text = str(shopping_menu.for_sale_item3.item_desc) 
		function_description.text = str(shopping_menu.for_sale_item3.function_text)

func _on_buy_item_button_3_pressed() -> void:
	if buy_item_function(shopping_menu.for_sale_item3, shopping_menu.item3_price):
		shopping_menu.has_bought_something = true
		$"Buy Item Button 3".queue_free()

func _on_buy_item_button_4_mouse_entered() -> void:
	if not is_talking:
		$Panel.show()
		item_name.text = "%s (Costs: $%.2f)" % [shopping_menu.for_sale_item4.item_name,shopping_menu.item4_price]
		description.text = str(shopping_menu.for_sale_item4.item_desc)
		function_description.text = str(shopping_menu.for_sale_item4.function_text)

func _on_buy_item_button_4_pressed() -> void:
	if buy_item_function(shopping_menu.for_sale_item4, shopping_menu.item4_price):
		shopping_menu.has_bought_something = true
		$"Buy Item Button 4".queue_free()

func _on_upgrade_rod_button_pressed() -> void:
	pass


func _on_upgrade_rod_button_mouse_entered() -> void:
	$Panel.show()
	item_name.text = "%s (Costs: $%.2f)" % [shopping_menu.buyable_rod.rod_name,shopping_menu.buyable_rod.rod_price]
	description.text = "An upgrade to the fishing rod."
	function_description.text = "Buying better fishing rods can let you get more damage from the hook."

func clear_description() -> void:
	if not is_talking:
		item_name.text = ""
		description.text = ""
		function_description.text = ""
		$Panel.hide()
		description.visible_characters = -1

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action("Select"):
		if not is_talking:
			clear_description()
			shopkeeper_dialogue("Test Dialogue","talking-normal", "idle")
			await get_tree().create_timer(2.5).timeout
		
		

func shopkeeper_dialogue(text : String, expression_talking : String, expression_idle : String) -> void:
	is_talking = true
	description.text = text
	description.visible_characters = 0
	$Panel.show()
	$Shopkeeper.play(expression_talking)
	for i in range(text.length()):
		description.visible_characters += 1
		await get_tree().create_timer(0.01).timeout
	$Shopkeeper.play(expression_idle)
	await get_tree().create_timer(2.5).timeout
	is_talking = false
	clear_description()
