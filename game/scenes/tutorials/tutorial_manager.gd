extends Control
var current_tutorial_deck : Array[String] = TutorialCatalogue.tutorial_beginning
var current_scene_id : int

@onready var tutorial_screen: Control = $"Tutorial Screen"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_tutorial_deck("BeginningTutorial")
	update_buttons()
	update_tutorials()
	
	
func set_tutorial_deck(deck : String) -> void:
	match deck:
		"BeginningTutorial":
			current_tutorial_deck = TutorialCatalogue.tutorial_beginning
		"ShoppingTutorial":
			current_tutorial_deck = TutorialCatalogue.tutorial_shopping
	current_scene_id = 0
	update_buttons()
	update_tutorials()

func update_tutorials() -> void:
	var title = TutorialCatalogue.tutorials.get(current_tutorial_deck[current_scene_id]).tutorial_title_str
	var text = TutorialCatalogue.tutorials.get(current_tutorial_deck[current_scene_id]).tutorial_text_str
	var image = TutorialCatalogue.tutorials.get(current_tutorial_deck[current_scene_id]).tutorial_image_str
	tutorial_screen.set_tutorial_text(title,text,image)
	tutorial_screen.type_tutorial_text()

func update_buttons() -> void:
	if current_scene_id == 0:
		$"Previous Button".hide()
	else:
		$"Previous Button".show()
	if current_scene_id == len(current_tutorial_deck) - 1:
		$"Next Button".hide()
		$"Skip Tutorial Button".text = "Close Tutorial"
	else:
		$"Next Button".show()
		$"Skip Tutorial Button".text = "Skip Tutorial"


func _on_next_button_pressed() -> void:
	current_scene_id += 1
	update_tutorials()
	update_buttons()

func _on_previous_button_pressed() -> void:
	current_scene_id -= 1
	update_tutorials()
	update_buttons()


func _on_skip_tutorial_button_pressed() -> void:
	match current_tutorial_deck:
		TutorialCatalogue.tutorial_beginning:
			GameController.tutorial_on = GameController.TutorialState.SHOPPING
		TutorialCatalogue.tutorial_shopping:
			GameController.tutorial_on = GameController.TutorialState.DONE
	queue_free()
