extends CharacterBody2D
class_name Fish

@onready var fishing_scene : Node2D = get_parent()
@onready var bobber_scene : AnimatedSprite2D = $"../Bobber"
@onready var target_position: Marker2D = $TargetPosition
@onready var ray_cast_2d: RayCast2D = $RayCast2D

var screen_size = Vector2(1152,648)
var r_x = randi_range(200, 960)
var r_y = randi_range(170, 300)

var fish_name : String
var value : float
var health : float
var img : String
var lore : String

var fish_size : String

var move_distance : float = 0.0
var move_angle : float = 0.0

@export var target_destination : Vector2 = self.position

enum State { WANDER, ATTRACT, STOP }
var state : State = State.WANDER

@export var agent : NavigationAgent2D

signal changed

func _init(c_fish_name : String = "Test Fish", c_value : float = 250.0, c_health : float = 125.0, c_img : String = "res://icon.svg", c_lore : String = "This is a test fish", c_size : String = "Medium") -> void:
	fish_name = c_fish_name
	value = c_value
	health = c_health
	img = c_img
	lore = c_lore
	fish_size = c_size
	self.position = Vector2(r_x, r_y)

func _ready() -> void:
	self.change_size()
	set_new_target_destination()

func _physics_process(delta: float) -> void:
	if self.position.x <= -10 or self.position.x >= screen_size.x + 10 or self.position.y <= -10 or self.position.y >= screen_size.y + 10:
		self.position = Vector2(screen_size.x / 2, screen_size.y / 2)
	match state:
		State.WANDER:
			if self.position == target_destination:
				#print("Arrived")
				set_new_target_destination()
				await get_tree().create_timer(0.25).timeout
		State.ATTRACT:
			if self.position == target_destination:
				fishing_scene.makeFish(self)
		State.STOP:
			velocity = Vector2.ZERO
			move_and_slide()
	
	self.position = self.position.move_toward(target_destination, 25 * delta)
	#print("Position: " + str(position))
	#print(ray_cast_2d.is_colliding())
	
func movement_choice() -> void:
	var choice = randi_range(1,2)
	match choice:
		1:
			state = State.WANDER
		2:
			state = State.STOP

func _to_string() -> String:
	return fish_name +": value: " + str(value) + " Health: " + str(health)

func set_new_target_destination() -> void:
	if state == State.WANDER:
		ray_cast_2d.enabled = true
		ray_cast_2d.target_position = Vector2.ZERO
		var new_relative_vector : Vector2 = generate_random_direction()
		ray_cast_2d.target_position = new_relative_vector
		if ray_cast_2d.is_colliding():
			new_relative_vector *= Vector2(-1,-1)
			print("Change Direction")
			print("Is Colliding")
		target_destination = self.position + new_relative_vector
		#print(target_destination)
		ray_cast_2d.enabled = false
		
	elif state == State.ATTRACT:
		#print("Bobber Position: %s" % bobber_scene.position)
		ray_cast_2d.target_position = bobber_scene.position - self.position
		#print("Ray Cast Position: %s" % (self.position + ray_cast_2d.target_position))
		if ray_cast_2d.is_colliding():
			print("Fish will go into wall.")
		target_destination = bobber_scene.position
	#if not ray_cast_2d.is_colliding():
		#set_new_target_destination()
	#else:
	
		
func set_attract_mode() -> void:
	if not state == State.ATTRACT:
		state = State.ATTRACT
		set_new_target_destination()
	
func set_wander_mode() -> void:
	if not state == State.WANDER:
		state = State.WANDER
		set_new_target_destination()

func change_size() -> void:
	match fish_size:
		"Small":
			self.scale *= Vector2(0.75,0.75)
		"Medium":
			self.scale *= Vector2(1.2,1.2)
		"Large":
			self.scale *= Vector2(2,2)

func generate_random_direction() -> Vector2:
	return Vector2(randi_range(-100, 100), randi_range(-50,50))
