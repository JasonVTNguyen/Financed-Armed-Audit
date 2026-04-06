extends Control

@onready var shopping_menu: Control = $"../.."

func _on_rep_primary_button_mouse_entered() -> void:
	pass # Replace with function body.

func _on_rep_primary_button_mouse_exited() -> void:
	pass # Replace with function body.

func _on_rep_primary_button_pressed() -> void:
	GameController.primary_gun = Gun.new(shopping_menu.for_sale_weapon.gun_name,shopping_menu.for_sale_weapon.gun_desc,shopping_menu.for_sale_weapon.gun_img.resource_path, shopping_menu.for_sale_weapon.damage, shopping_menu.for_sale_weapon.cap_ammo, shopping_menu.for_sale_weapon.max_ammo, shopping_menu.for_sale_weapon.mag_size, shopping_menu.for_sale_weapon.reload_time, shopping_menu.for_sale_weapon.fire_rate)
	GameController.primary_gun_upgrades = []
	queue_free()
	
func _on_rep_secondary_button_mouse_entered() -> void:
	pass # Replace with function body.

func _on_rep_secondary_button_mouse_exited() -> void:
	pass # Replace with function body.
	
func _on_rep_secondary_button_pressed() -> void:
	GameController.secondary_gun = Gun.new(shopping_menu.for_sale_weapon.gun_name,shopping_menu.for_sale_weapon.gun_desc,shopping_menu.for_sale_weapon.gun_img.resource_path, shopping_menu.for_sale_weapon.damage, shopping_menu.for_sale_weapon.cap_ammo, shopping_menu.for_sale_weapon.max_ammo, shopping_menu.for_sale_weapon.mag_size, shopping_menu.for_sale_weapon.reload_time, shopping_menu.for_sale_weapon.fire_rate)
	GameController.secondary_gun_upgrades = []
	queue_free()
