extends Control

var qte_meter_count : float = 0.0
@onready var fishing_meter: ProgressBar = $"QTE Panel/Fishing Meter"

const timing_offset = 0.075

var increments1 : float = 9000
var increments2 : float = 9000
var increments3 : float = 9000

var is_counting : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"QTE Panel/Increment 1".hide()
	$"QTE Panel/Increment 2".hide()
	$"QTE Panel/Increment 3".hide()
	random_increments()
	#print("Increment 1: ", increments1)
	$"QTE Panel/Increment 1".position.y = (1 - increments1) * $"QTE Panel".size.y
	if GameController.current_rod.rod_tier > 0:
		#print("Increment 2: ", increments2)
		$"QTE Panel/Increment 2".position.y = (1 - increments2) * $"QTE Panel".size.y
	if GameController.current_rod.rod_tier > 1:
		#print("Increment 3: ", increments3)
		$"QTE Panel/Increment 3".position.y = (1 - increments3) * $"QTE Panel".size.y
	await get_tree().create_timer(0.75).timeout
	is_counting = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if qte_meter_count >= 100 and is_counting:
		next_phase()
	if check_if_within_increment1(timing_offset):
		$"QTE Panel/Increment 1/Increment 1 Number".text = "Now"
	else:
		$"QTE Panel/Increment 1/Increment 1 Number".text = ""
	if GameController.current_rod.rod_tier > 0:
		if check_if_within_increment2(timing_offset):
			$"QTE Panel/Increment 2/Increment 2 Number".text = "Now"
		else:
			$"QTE Panel/Increment 2/Increment 2 Number".text = ""
	if GameController.current_rod.rod_tier > 1:
		if check_if_within_increment3(timing_offset):
			$"QTE Panel/Increment 3/Increment 3 Number".text = "Now"
		else:
			$"QTE Panel/Increment 3/Increment 3 Number".text = ""
	if is_counting:
		qte_meter_count += 0.05
	update_values()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Select"):
		if check_if_within_increment1(timing_offset):
			print("Landed 1")
			increments1 = 9000
			GameController.fishing_qte_score += 1
		if GameController.current_rod.rod_tier > 0:
			if check_if_within_increment2(timing_offset):
				print("Landed 2")
				GameController.fishing_qte_score += 1
				increments2 = 9000
		if GameController.current_rod.rod_tier > 1:
			if check_if_within_increment3(timing_offset):
				print("Landed 3")
				GameController.fishing_qte_score += 1
				increments3 = 9000

func random_increments():
	increments1 = randf_range(0.2, 0.95)
	$"QTE Panel/Increment 1".show()
	if GameController.current_rod.rod_tier > 0:
		increments2 = randf_range(0.2, 0.95)
		$"QTE Panel/Increment 2".show()
	if GameController.current_rod.rod_tier > 1:
		increments3 = randf_range(0.2, 0.95)
		$"QTE Panel/Increment 3".show()
	
func update_values() -> void:
	$"QTE Panel/Fishing Meter".value = qte_meter_count
	$"QTE Panel/Increment 1".position.y = (1 - increments1) * $"QTE Panel".size.y
	if GameController.current_rod.rod_tier > 0:
		$"QTE Panel/Increment 2".position.y = (1 - increments2) * $"QTE Panel".size.y
	if GameController.current_rod.rod_tier > 1:
		$"QTE Panel/Increment 3".position.y = (1 - increments3) * $"QTE Panel".size.y

func check_if_within_increment1(offset : float):
	var qte_modified = qte_meter_count / 100
	if qte_modified <= increments1 + offset and qte_modified >= increments1 - offset:
		return true
	return false

func check_if_within_increment2(offset : float):
	var qte_modified = qte_meter_count / 100
	if qte_modified <= increments2 + offset and qte_modified >= increments2 - offset:
		return true
	return false
	
func check_if_within_increment3(offset : float):
	var qte_modified = qte_meter_count / 100
	if qte_modified <= increments3 + offset and qte_modified >= increments3 - offset:
		return true
	return false

func _on_test_button_pressed() -> void:
	random_increments()
	is_counting = true
	qte_meter_count = 0.0
	GameController.fishing_qte_score = 0

func next_phase() -> void:
	#print("Stopped Counting")
	print(GameController.fishing_qte_score)
	is_counting = false
	if GameController.currentFish.health <= GameController.current_hook.hook_damage:
		GameController.money += GameController.currentFish.value
		GameController.rounds_fish_caught.append(GameController.currentFish)
		if GameController.current_bait > 0:
			get_tree().change_scene_to_file("res://game/scenes/fishing/fishing.tscn")
		else:
			print("Total Value: " + str(GameController.total_value))
			print("Round Goal: " + str(GameController.story_round_objectives.get(GameController.current_round)))
			get_tree().change_scene_to_file("res://game/scenes/results/results_screen.tscn")
	else:
		get_tree().change_scene_to_file("res://game/scenes/shooting/shooting_phase.tscn")
