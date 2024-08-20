extends Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("pressed", self._on_button_pressed)

# Function to handle button press
func _on_button_pressed() -> void:
	if MusicManager.playing:
		MusicManager.stop()
	else:
		MusicManager.play()
