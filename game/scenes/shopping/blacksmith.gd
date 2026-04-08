extends Control

@onready var money: Label = $Money
@onready var description_name: Label = $"Panel/VBoxContainer/Description Name"
@onready var description_text: Label = $"Panel/VBoxContainer/Description Text"
@onready var shopping_menu: Control = $".."
@onready var replace_weapon_panel: Control = $"Replace Weapon Panel"
@onready var panel: Panel = $Panel
@onready var buy_ammo_panel: Control = $"Buy Ammo Panel"

var is_talking : bool = false
var purchasable_weapon : Gun

signal switch_scene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_labels()
	$Shopkeeper.play("idle")
	replace_weapon_panel.hide()
	buy_ammo_panel.hide()
	purchasable_weapon = shopping_menu.for_sale_weapon

func _on_to_shop_button_pressed() -> void:
	switch_scene.emit()

func _on_buy_ammo_button_pressed() -> void:
	if not GameController.secondary_gun:
		if GameController.money >= GameController.primary_gun.ammo_price:
			print("Secondary Gun does not exist.")
			GameController.primary_gun.add_to_ammo_capacity(GameController.primary_gun.ammo_purchase_amt)
			GameController.money -= GameController.primary_gun.ammo_price
			$"Buy SFX".show()
		else:
			shopkeeper_dialogue("Listen, I get it, you're broke. But if you can't even afford to buy ammo, then you really need to start going after the big fish.","talking","idle")
			await get_tree().create_timer(3).timeout
			is_talking = false
	else:
		buy_ammo_panel.show()
		
	update_labels()

func update_labels() -> void:
	if not is_talking:
		panel.hide()
		money.text = "Cash: $%.2f" % GameController.money
		description_text.text = ""
		description_name.text = ""
		description_text.visible_characters = -1

func _on_buy_weapon_button_pressed() -> void:
	if GameController.money >= shopping_menu.for_sale_weapon.price:
		if not GameController.secondary_gun:
			print("Secondary does not exist")
			GameController.secondary_gun = Gun.new(shopping_menu.for_sale_weapon.gun_name, shopping_menu.for_sale_weapon.damage, shopping_menu.for_sale_weapon.cap_ammo, shopping_menu.for_sale_weapon.max_ammo, shopping_menu.for_sale_weapon.mag_size, shopping_menu.for_sale_weapon.reload_time, shopping_menu.for_sale_weapon.fire_rate)
		else:
			replace_weapon_panel.show()
		GameController.money -= shopping_menu.for_sale_weapon.price
		$"Buy SFX".play()
		update_labels()
		$"Buy Weapon Button".queue_free()
	else:
		description_name.text = ""
		shopkeeper_dialogue("Oi, you trying to fleece me? Bring the cash next time, or else you'll be the first thing this gun's shooting.","talking","idle")
		

func _on_buy_weapon_button_mouse_entered() -> void:
	panel.show()
	if shopping_menu.for_sale_weapon:
		description_name.text = "Name: %s (Costs: $%.2f)" % [shopping_menu.for_sale_weapon.gun_name, shopping_menu.for_sale_weapon.price]
		description_text.text = ""

func _on_buy_weapon_button_mouse_exited() -> void:
	if not is_talking:
		panel.hide()

func _on_buy_ammo_button_mouse_entered() -> void:
	panel.show()
	description_name.text = ""
	description_text.text = "Buy Ammunition for your gun."
	
func _on_buy_ammo_button_mouse_exited() -> void:
	if not is_talking:
		panel.hide()

func shopkeeper_dialogue(text : String, expression_talking : String, expression_idle : String) -> void:
	is_talking = true
	description_text.text = text
	description_text.visible_characters = 0
	$Panel.show()
	$Shopkeeper.play(expression_talking)
	for i in range(text.length()):
		description_text.visible_characters += 1
		await get_tree().create_timer(0.01).timeout
	$Shopkeeper.play(expression_idle)
	await get_tree().create_timer(2.5).timeout
	update_labels()


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action("Select"):
		if not is_talking:
			update_labels()
			shopkeeper_dialogue("Huh? Why do I call this a 'blacksmith' when it's just the area behind the counter? Trade secret.","talking", "idle")
			await get_tree().create_timer(2.5).timeout
			is_talking = false
