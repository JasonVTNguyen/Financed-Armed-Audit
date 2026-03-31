extends Control

@onready var money: Label = $Money
@onready var description_name: Label = $"Panel/VBoxContainer/Description Name"
@onready var description_text: Label = $"Panel/VBoxContainer/Description Text"
@onready var shopping_menu: Control = $".."
@onready var replace_weapon_panel: Control = $"Replace Weapon Panel"
@onready var panel: Panel = $Panel

var purchasable_weapon : Gun

signal switch_scene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_labels()
	replace_weapon_panel.hide()
	purchasable_weapon = shopping_menu.for_sale_weapon

func _on_to_shop_button_pressed() -> void:
	switch_scene.emit()

func _on_buy_ammo_button_pressed() -> void:
	if GameController.money >= GameController.primary_gun.ammo_price:
		GameController.primary_gun.add_to_ammo_capacity(GameController.primary_gun.ammo_purchase_amt)
		if GameController.secondary_gun:
			GameController.secondary_gun.add_to_ammo_capacity(100)
	update_labels()

func update_labels() -> void:
	panel.hide()
	money.text = "Cash: $%.2f" % GameController.money
	description_text.text = ""
	description_name.text = ""

func _on_buy_weapon_button_pressed() -> void:
	if GameController.money >= shopping_menu.for_sale_weapon.price:
		if not GameController.secondary_gun:
			print("Secondary does not exist")
			GameController.secondary_gun = Gun.new(shopping_menu.for_sale_weapon.gun_name, shopping_menu.for_sale_weapon.damage, shopping_menu.for_sale_weapon.cap_ammo, shopping_menu.for_sale_weapon.max_ammo, shopping_menu.for_sale_weapon.mag_size, shopping_menu.for_sale_weapon.reload_time, shopping_menu.for_sale_weapon.fire_rate)
		else:
			replace_weapon_panel.show()
		update_labels()
		$"Buy Weapon Button".queue_free()
	else:
		description_text.text = "Oi, you trying to fleece me? Bring the cash next time, or else you'll be the first thing this gun's shooting."
		description_name.text = ""
func _on_buy_weapon_button_mouse_entered() -> void:
	panel.show()
	if shopping_menu.for_sale_weapon:
		description_name.text = "Name: %s (Costs: $%.2f)" % [shopping_menu.for_sale_weapon.gun_name, shopping_menu.for_sale_weapon.price]
		description_text.text = ""

func _on_buy_weapon_button_mouse_exited() -> void:
	panel.hide()
	description_name.text = ""
	description_text.text = ""
