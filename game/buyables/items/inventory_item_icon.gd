extends Control
class_name InventoryItem

var inv_item : Item
@onready var icon_bit: Sprite2D = $IconBit

signal itemhover_over
signal itemhover_off

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(inv_item)
	icon_bit.texture = inv_item.item_texture

func _on_area_2d_mouse_entered() -> void:
	print("Currently Hovering Over Item")
	print(inv_item.item_name)
	itemhover_over.emit(inv_item)

func _on_area_2d_mouse_exited() -> void:
	print("Not Anymore")
	itemhover_off.emit()

func update_icon() -> void:
	pass
	#icon_bit.texture = inv_item.item_texture
