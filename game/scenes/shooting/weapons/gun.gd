extends Node2D

class_name Gun

@onready var gunshot_particles: GPUParticles2D = $Gunshot

@export var gun_name : String # Name of the Gun
@export var damage : int # Base Damage before Modifier
@export var cap_ammo : int # How much Ammo can fit in Reserves
@export var max_ammo : int # How much Ammo is in Reserves 
@export var cur_ammo : int # How much Ammo is currently in the magazine
@export var mag_size : int # How much Ammo can fit in Magazine
@export var buyable_ammo : int # How much Ammo can be bought at once.

@export var gun_desc : String # Description of the Gun
@export var gun_img : Texture # What does the Gun look like

@export var price : float # How much does this gun cost?
@export var ammo_price : float # For how much does ammo cost?
@export var ammo_purchase_amt : int # How much ammo can you buy at once?

var reload_time : float # How long it takes to reload
var fire_rate : float 


var is_reloading : bool = false

@export var gun_upgrades : Array[Upgrade] = []

func _ready() -> void:
	#print("Gun Class Loaded")
	#if gunshot_particles:
		#print("Particles on")
	self.append_to_gun_upgrades(Catalogue.weapon_upgrades.get(0))
	#print(gun_upgrades)

func _process(delta: float) -> void:
	position = get_viewport().get_mouse_position()

func _init(c_gun_name : String = "Test Gun", c_gun_desc : String = "Test Description", c_gun_texture : String = "res://icon.svg", c_damage : int = 0, c_cap_ammo : int = 999999999, c_max_ammo : int = 999999999, c_mag_size : int = 10, c_reload_time : float = 1.0, c_fire_rate : float = 15.0, c_price : float = 0.0, c_ammo_price : float = 0.0, c_ammo_purchase_amt : int = 10) -> void:
	gun_name = c_gun_name
	gun_desc = c_gun_desc
	gun_img = load(c_gun_texture)
	damage = c_damage
	cap_ammo = c_cap_ammo
	max_ammo = c_max_ammo
	cur_ammo = c_mag_size
	mag_size = c_mag_size
	reload_time = c_reload_time
	price = c_price
	ammo_price = c_ammo_price
	ammo_purchase_amt = c_ammo_purchase_amt
	

func append_to_gun_upgrades(upgrade : Upgrade):
	gun_upgrades.append(upgrade)

func check_can_fire_gun() -> bool:
	if cur_ammo > 0:
		return true
	return false

func check_no_more_ammo() -> bool:
	if max_ammo <= 0 and cur_ammo <= 0:
		return true
	return false

func reload_calculation() -> int:
	var used_ammo = mag_size - cur_ammo
	if used_ammo <= max_ammo:
		return used_ammo
	else:
		return max_ammo

func fire_gun():
	if check_can_fire_gun():
		#print("Gunshot Particles: " + str(gunshot_particles))
		#print("Sprite: " + str($Sprite2D))
		cur_ammo -= 1
	
func reload_gun() -> void:
	var give_ammo = reload_calculation()
	max_ammo -= give_ammo
	cur_ammo += give_ammo

func add_to_ammo_capacity(ammo : int) -> void:
	if max_ammo + ammo > cap_ammo:
		max_ammo = cap_ammo
	else:
		max_ammo += ammo

func _to_string() -> String:
	return "Gun Name: " + gun_name + ", Damage: " + str(damage)

func _on_damage_radius_area_entered(area: Area2D) -> void:
	GameController.gun_state = GameController.GunState.HIT
	#print("shot will hit")

func _on_damage_radius_area_exited(area: Area2D) -> void:
	GameController.gun_state = GameController.GunState.MISS
	#print("shot will miss")
