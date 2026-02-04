extends Node2D

@onready var health_bar: ProgressBar = $"Health Bar"

var current_gun : Gun
var new_target = Target_Fish.new(GameController.currentFish.health)
var total_damage = 0

const switchGun = 2000
var hold_timer

func _ready() -> void:
	GameController.primary_gun = Gun.new("Pistol", 5, 5000, 20, 10)
	GameController.secondary_gun = Gun.new("Shotgun", 25, 3500, 50, 5)
	health_bar.max_value = new_target.target_max_health
	health_bar.value = new_target.target_max_health
	current_gun = GameController.primary_gun
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	update_labels()
	print(current_gun)

func _process(delta: float) -> void:
	if Input.is_action_pressed("Switch Weapons"):
		if hold_timer < 1:
			hold_timer += delta
	elif Input.is_action_just_released("Reload"):
			if hold_timer >= 0.5:
				if current_gun == GameController.primary_gun:
					current_gun = GameController.secondary_gun
				else:
					current_gun = GameController.primary_gun
				print("Switch Weapons")
			else:
				current_gun.reload_gun()
			hold_timer = 0
	else:
		hold_timer = 0
	if new_target.target_cur_health <= 0:
		target_dead()
	update_labels()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Shoot"):
		if current_gun.fire_gun():
			print("gun shot")
	update_labels()

func target_dead():
	GameController.total_weight += GameController.currentFish.weight
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if GameController.current_bait > 0:
		get_tree().change_scene_to_file("res://game/scenes/fishing/fishing.tscn")
	else:
		get_tree().change_scene_to_file("res://game/scenes/shopping/shopping_menu.tscn")

func damage_calculation():
	var damage : int = current_gun.damage
	return damage

func update_damage():
	if current_gun.check_can_fire_gun():
		total_damage += current_gun.damage
		new_target.damage_target(damage_calculation())
		health_bar.value -= damage_calculation()
		update_labels()
		return true
	return false

func update_labels() -> void:
	$"Weapon Name".text = str(current_gun.gun_name)
	$"Fish Health".text = str(new_target.target_cur_health) + " / " + str(new_target.target_max_health)
	$"Fish Name".text = str(GameController.currentFish.fish_name)
	$Ammo.text = "Ammo: " + str(current_gun.cur_ammo) + " / " + str(current_gun.mag_size) + " / " + str(current_gun.max_ammo)
	$"DPS Label".text = "You have done " + str(total_damage)+ " damage."
	$"Fish Health".text = str(new_target.target_cur_health) + " / " + str(new_target.target_max_health)
	if not current_gun.check_can_fire_gun():
		$Ammo.text = "RELOAD!"
	if current_gun.check_no_more_ammo():
		$Ammo.text = "All Out of Ammo!"
	else:
		$Ammo.text = "Ammo: " + str(current_gun.cur_ammo) + " / " + str(current_gun.mag_size) + " / " + str(current_gun.max_ammo)
