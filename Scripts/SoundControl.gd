extends Button

var audio : AudioStreamPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("pressed", self._on_button_pressed)
	audio = get_node("audio")

# Function to handle button press
func _on_button_pressed() -> void:
	#var aud = $AudioStreamPlayer
	audio.stream_paused = true
