extends Button

# Path to your main game scene
#var main_game_scene_path: String = "res://Scenes/World.tscn"
var simultaneous_scene = preload("res://Scenes/World.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Connect the button's pressed signal to the _on_button_pressed function
	connect("pressed", self._on_button_pressed)

# Function to handle button press
func _on_button_pressed() -> void:
	# Change the scene to the main game scene
	var scene_tree = get_tree()
	#scene_tree.change_scene(main_game_scene_path)
	get_tree().root.add_child(simultaneous_scene)
