extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var total : float
	var beginning = Caught_Fish.new_fish("Beginning Balance", GameController.money_at_beginning)
	$Panel/VBoxContainer.add_child(beginning)
	beginning.update_labels()
	
	for fish in GameController.rounds_fish_caught:
		total += fish.value
		var caught = Caught_Fish.new_fish(fish.fish_name, fish.value)
		$Panel/VBoxContainer.add_child(caught)
		caught.update_labels()
		await get_tree().create_timer(0.75).timeout

	var subtract_goal = Caught_Fish.new_fish("Deduct: Tax Installment", -1 *GameController.story_round_objectives.get(GameController.current_round))
	$Panel/VBoxContainer.add_child(subtract_goal)
	subtract_goal.update_labels()
	
	var leftover = GameController.money_at_beginning + total - GameController.story_round_objectives.get(GameController.current_round)

	$"Total Leftover".text = "Total Leftover: $%.2f" % leftover
	
func _on_continue_button_pressed() -> void:
	GameController.rounds_fish_caught = []
	if GameController.money >= GameController.story_round_objectives.get(GameController.current_round):
		print("Value Exceeded.")
		GameController.money -= GameController.story_round_objectives.get(GameController.current_round)
		GameController.current_round += 1
		get_tree().change_scene_to_file("res://game/scenes/shopping/shopping_menu.tscn")
	else:
		print("Game Over")
		get_tree().change_scene_to_file("res://game/scenes/mainmenu/main_menu.tscn")
