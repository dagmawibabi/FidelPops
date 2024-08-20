extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_score_display()

# This function updates the RichTextLabel with the current score
func update_score_display() -> void:
	$Label.text = "Score: " + str(ScoreManager.score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_score_display()  # Continuously update the label with the latest score
