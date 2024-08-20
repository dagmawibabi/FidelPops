extends Control

# Declare member variables
var heart_sprites = []  # Array to hold references to heart sprites
var hearts: int = 3  # Initial number of hearts

func _ready() -> void:
	# Initialize the heart sprites array
	heart_sprites.append($Heart1)
	heart_sprites.append($Heart2)
	heart_sprites.append($Heart3)
	update_heart_display()

func update_heart_display() -> void:
	# Update the visibility of the heart sprites
	for i in range(3):
		if i < hearts:
			heart_sprites[i].texture = preload("res://Assets/Heart/heart.png")  # Adjust the path as needed
		else:
			heart_sprites[i].texture = preload("res://Assets/Heart/emptyheart.png")  # Adjust the path as needed

func decrease_hearts() -> void:
	if hearts > 0:
		hearts -= 1
		update_heart_display()
	if hearts == 0:
		game_over()  # Call a function to handle game over logic

func game_over() -> void:
	# Implement game over logic here
	print("Game Over!")
