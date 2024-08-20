extends CharacterBody2D

# Initialize velocity
var velocityVec = Vector2(0, 0)

func _ready() -> void:
	# Optionally, set default values or initial setup
	scale = Vector2(0.15, 0.15)
	pass
	
func _physics_process(delta: float) -> void:
	# Move the bullet based on its velocity
	position += velocity * delta
	# Optionally, remove the bullet if it goes off-screen
	if position.y < 0 or position.y > get_viewport().size.y:
		queue_free()

# Optional method to set the velocity from the player script
func set_velocityVec(new_velocity: Vector2) -> void:
	velocity = new_velocity
