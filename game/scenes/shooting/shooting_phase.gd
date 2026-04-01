extends Node2D

@onready var modifier_handler: ModifierHandler = $ModifierHandler

@onready var health_bar: ProgressBar = $"HUD Elements/Health Bar"
@onready var reload_bar: ProgressBar = $"HUD Elements/Reload Bar"
@onready var fire_rate_bar: ProgressBar = $"HUD Elements/FireRate Bar"
@onready var switch_weapon_bar: ProgressBar = $"HUD Elements/Switch Weapon Bar"
@onready var gunshot_particles: CPUParticles2D = $"Gunshot Particles"

@onready var reload_timer: Timer = $ReloadTimer
@onready var fire_rate_timer : Timer = $FireRateTimer
@onready var switch_timer: Timer = $SwitchTimer

var current_gun : Gun
var new_target : Target_Fish
var total_damage = 0

var reload_time : float = 0

@export var _fire_frames : int = 50
@export var _fire_rate : int = 1

const switchGun : int = 2000
var hold_timer : float = 0


func _ready() -> void:
	print("Shooting Test: "+ str(GameController.currentFish))
	new_target = Target_Fish.new(GameController.currentFish.health)
	health_bar.max_value = new_target.target_max_health
	health_bar.value = new_target.target_max_health
	current_gun = GameController.primary_gun
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	apply_hook_damage()
	if new_target.target_cur_health <= 0:
		target_dead()
	update_labels()
	
	#GameController.primary_gun.append_to_gun_upgrades(Catalogue.weapon_upgrades.get(0))
	
	print(current_gun)
	$"HUD Elements/Reload Bar".max_value = current_gun.reload_time
	$"HUD Elements/FireRate Bar".max_value = current_gun.fire_rate
	$"HUD Elements/Switch Weapon Bar".max_value = 1

func _process(delta: float) -> void:
	if new_target.target_cur_health <= 0:
		target_dead()
	update_labels()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Shoot"):
		GameController.number_of_shots += 1
		if GameController.gun_state == GameController.GunState.HIT and reload_timer.is_stopped() and switch_timer.is_stopped():
			if update_damage():
				
				#self.add_child(gunshot_particles)
				gunshot_particles.emitting = false
				gunshot_particles.position = $Gun.position
				
				gunshot_particles.emitting = true
				$"Target Fish".target_hit()
		if reload_timer.is_stopped() and switch_timer.is_stopped():
			current_gun.fire_gun()
	elif event.is_action_pressed("Reload"):
		current_gun.reload_gun()
		reload_time = current_gun.reload_time
		reload_timer.start(current_gun.reload_time)
	elif event.is_action_pressed("Switch Weapons") and GameController.secondary_gun and switch_timer.is_stopped():
		if current_gun == GameController.primary_gun:
			current_gun = GameController.secondary_gun
		else:
			current_gun = GameController.primary_gun
			$"HUD Elements/Reload Bar".max_value = current_gun.reload_time
			$"HUD Elements/FireRate Bar".max_value = current_gun.fire_rate
		print("Switch Weapons")
		switch_timer.start(1)
	update_labels()

func target_dead():
	var value : float = GameController.currentFish.value
	for item : Item in GameController.inventory.items:
		if item.item_type == Item.Item_Type.VALUE:
			value += item.apply_conditional_flat()
	for item : Item in GameController.inventory.items:
		if item.item_type == Item.Item_Type.VALUE:
			value *= item.apply_conditional_percent()
	GameController.money += value
	GameController.rounds_fish_caught.append(GameController.currentFish)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if GameController.current_bait > 0:
		get_tree().change_scene_to_file("res://game/scenes/fishing/fishing.tscn")
	else:
		print("Total Value: " + str(GameController.money))
		print("Round Goal: " + str(GameController.story_round_objectives.get(GameController.current_round)))
		get_tree().change_scene_to_file("res://game/scenes/results/results_screen.tscn")
			
func damage_calculation():
	#print("Damage Dealt")
	#print(current_gun.gun_upgrades)
	var damage : int = current_gun.damage
	for item : Item in GameController.inventory.items:
		if item.item_type == Item.Item_Type.SHOOTING:
			damage += item.apply_conditional_flat()
	for upgrade in current_gun.gun_upgrades: # Flat Value Handler
		if upgrade is Bullet_Upgrade:
			damage += upgrade.flat_dmg
	
	for item : Item in GameController.inventory.items:
		if item.item_type == Item.Item_Type.SHOOTING:
			damage *= item.apply_conditional_percent()
	for upgrade in current_gun.gun_upgrades: # Flat Value Handler
		if upgrade is Bullet_Upgrade:
			damage *= upgrade.percent_dmg
	
	return floor(damage)

func update_damage():
	if current_gun.check_can_fire_gun():
		if GameController.gun_state == GameController.GunState.HIT:
			total_damage += current_gun.damage
			new_target.damage_target(damage_calculation())
			health_bar.value -= damage_calculation()
		update_labels()
		return true
	return false

func update_labels() -> void:
	$"HUD Elements/Reload Bar".value = reload_timer.time_left
	$"HUD Elements/FireRate Bar".value = fire_rate_timer.time_left
	$"HUD Elements/Switch Weapon Bar".value = switch_timer.time_left
	$"HUD Elements/Weapon Name".text = str(current_gun.gun_name)
	$"HUD Elements/Fish Health".text = str(new_target.target_cur_health) + " / " + str(new_target.target_max_health)
	$"HUD Elements/Fish Name".text = str(GameController.currentFish.fish_name)
	$"HUD Elements/Ammo".text = "Ammo: " + str(current_gun.cur_ammo) + " / " + str(current_gun.mag_size) + " / " + str(current_gun.max_ammo)
	$"HUD Elements/Fish Health".text = str(new_target.target_cur_health) + " / " + str(new_target.target_max_health)
	
	if not current_gun.check_can_fire_gun():
		$"HUD Elements/Ammo".text = "RELOAD!"
	if current_gun.check_no_more_ammo():
		$"HUD Elements/Ammo".text = "All Out of Ammo!"
	else:
		$"HUD Elements/Ammo".text = "Ammo: " + str(current_gun.cur_ammo) + " / " + str(current_gun.mag_size) + " / " + str(current_gun.max_ammo)

func apply_hook_damage() -> void:
	var hook_damage = GameController.current_hook.hook_damage 
	hook_damage *= 1 + GameController.fishing_qte_score / 10
	new_target.damage_target(hook_damage)
	health_bar.value -= hook_damage
