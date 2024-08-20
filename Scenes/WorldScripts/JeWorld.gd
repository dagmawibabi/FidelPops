extends Node2D

# Preload your CharacterBody2D scene
var character_scene = preload("res://Scenes/Bubbles/JeB.tscn")

# Set the number of characters you want to spawn
var character_count = 7

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Spawn multiple characters
	for i in range(character_count):
		spawn_character()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape"):
		var simultaneous_scene = preload("res://Scenes/AreaSelector.tscn").instantiate()
		var scene_tree = get_tree()
		get_tree().root.add_child(simultaneous_scene)

# Function to spawn a character at a random position
func spawn_character():
	var character = character_scene.instantiate() # Create a new instance
	add_child(character) # Add the character to the scene
