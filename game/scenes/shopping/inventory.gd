extends Node
class_name Inventory

signal close_inventory
@onready var name_label: Label = $"Panel/Name Label"
@onready var description_label: Label = $"Panel/Description Label"
@onready var item_icon: Sprite2D = $"Panel/Item Icon"
@onready var items_container: HFlowContainer = $"Panel/Items Container"

const inv_item : PackedScene = preload("res://game/buyables/items/inventory_item_icon.tscn")

var items : Array[Item]

func add_item(item) -> void:
	print("Item added.")
	items.append(item)
	
func remove_item(item) -> void:
	var item_loc : int = find_item(item)
	if item_loc:
		items.remove_at(item_loc)
	else:
		print("Item not found.")
	
func find_item(item):
	for x in range(len(items)):
		if items[x] == item:
			return x
	return null

func _on_close_inventory_button_pressed() -> void:
	close_inventory.emit()

func update_labels() -> void:
	for x in items_container.get_children():
		x.queue_free()
		
	if len(GameController.inventory.items) > 0:
		for item in GameController.inventory.items:
			var new_icon = inv_item.instantiate()
			new_icon.inv_item = item
			new_icon.update_icon()
			items_container.add_child(new_icon)
			new_icon.connect("itemhover_over",show_item_description)
			new_icon.connect("itemhover_off",clear_description_label)

	$"Panel/Primary Weapon Box/VBoxContainer/Primary Gun".text = str(GameController.primary_gun.gun_name)
	$"Panel/Primary Weapon Box/VBoxContainer/Primary Ammo".text = str(GameController.primary_gun.cur_ammo) + " / " + str(GameController.primary_gun.max_ammo)
	if GameController.secondary_gun:
		$"Panel/Secondary Weapon Box/VBoxContainer/Secondary Gun".text = str(GameController.secondary_gun.gun_name)
		$"Panel/Secondary Weapon Box/VBoxContainer/Secondary Ammo".text = str(GameController.secondary_gun.cur_ammo) + " / " + str(GameController.secondary_gun.max_ammo)

func _on_primary_weapon_box_mouse_entered() -> void:
	description_label.text = str(GameController.primary_gun.gun_desc)
	name_label.text = str(GameController.primary_gun.gun_name)
	item_icon.texture = GameController.primary_gun.gun_img
	item_icon.show()
	
func _on_secondary_weapon_box_mouse_entered() -> void:
	if GameController.secondary_gun:
		description_label.text = str(GameController.secondary_gun.gun_desc)
		name_label.text = str(GameController.secondary_gun.gun_name)
		item_icon.texture = GameController.secondary_gun.gun_img
		item_icon.show()

func show_item_description(item : Item) -> void:
	description_label.text = "%s\n%s" % [item.item_desc, item.function_text]
	name_label.text = str(item.item_name)
	item_icon.texture = item.item_texture
	item_icon.show()

func clear_description_label() -> void:
	description_label.text = ""
	name_label.text = ""
	item_icon.hide()
