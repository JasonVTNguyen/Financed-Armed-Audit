extends Control

@onready var shopping_menu: Control = $"../.."
@onready var blacksmith: Control = get_parent()
@onready var description: Label = $Panel/Description
@onready var primary_gun_name: Label = $"Panel/Primary Ammo Button/Primary Gun Name"
@onready var primary_ammo: Label = $"Panel/Primary Ammo Button/Primary Ammo"
@onready var secondary_gun_name: Label = $"Panel/Secondary Ammo Button/Secondary Gun Name"
@onready var secondary_ammo: Label = $"Panel/Secondary Ammo Button/Secondary Ammo"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_buttons()


func _on_primary_ammo_button_pressed() -> void:
	if GameController.money >= GameController.primary_gun.ammo_price:
		GameController.primary_gun.add_to_ammo_capacity(GameController.primary_gun.ammo_purchase_amt)
		GameController.money -= GameController.primary_gun.ammo_price
		blacksmith.update_labels()
		$"Buy SFX".play()
	self.hide()

func _on_secondary_ammo_button_pressed() -> void:
	if GameController.money >= GameController.secondary_gun.ammo_price:
		GameController.secondary_gun.add_to_ammo_capacity(GameController.secondary_gun.ammo_purchase_amt)
		GameController.money -= GameController.secondary_gun.ammo_price
		blacksmith.update_labels()
		$"Buy SFX".play()
	self.hide()

func update_buttons() -> void:
	primary_gun_name.text = GameController.primary_gun.gun_name
	primary_ammo.text = "Magazine: %d / %d | Capacity: %d" % [GameController.primary_gun.cur_ammo, GameController.primary_gun.mag_size, GameController.primary_gun.max_ammo]
	secondary_gun_name.text = GameController.secondary_gun.gun_name
	secondary_ammo.text = "Magazine: %d / %d | Capacity: %d" % [GameController.secondary_gun.cur_ammo, GameController.secondary_gun.mag_size, GameController.secondary_gun.max_ammo]

func clear_description() -> void:
	description.text = ""


func _on_primary_ammo_button_mouse_entered() -> void:
	description.text = "You can buy %d bullets for $%.2f" % [GameController.primary_gun.ammo_purchase_amt,GameController.primary_gun.ammo_price]


func _on_secondary_ammo_button_mouse_entered() -> void:
	description.text = "You can buy %d bullets for $%.2f" % [GameController.secondary_gun.ammo_purchase_amt,GameController.secondary_gun.ammo_price]

func _on_cancel_button_pressed() -> void:
	self.hide()
