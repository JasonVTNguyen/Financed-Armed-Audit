extends Control

@onready var shopping_menu: Control = $"../.."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_primary_ammo_button_pressed() -> void:
	if GameController.money >= GameController.primary_gun.ammo_price:
		GameController.primary_gun.add_to_ammo_capacity(GameController.primary_gun.ammo_purchase_amt)
		GameController.money -= GameController.primary_gun.ammo_price
	self.hide()

func _on_secondary_ammo_button_pressed() -> void:
	if GameController.money >= GameController.secondary_gun.ammo_price:
		GameController.secondary_gun.add_to_ammo_capacity(GameController.secondary_gun.ammo_purchase_amt)
		GameController.money -= GameController.secondary_gun.ammo_price
	self.hide()
