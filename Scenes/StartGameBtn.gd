extends Button

@export var scene: String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("pressed", self._on_button_pressed)

# Function to handle button press
func _on_button_pressed() -> void:
	var scene_tree = get_tree()
	
	if scene != "":
		var scene_resource = load(scene)
		
		if scene_resource:
			var new_scene = scene_resource.instantiate()
			scene_tree.root.add_child(new_scene)
		else:
			print("Failed to load scene: ", scene)
	else:
		print("Scene path is empty")
