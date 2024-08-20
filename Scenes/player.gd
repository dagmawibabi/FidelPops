extends CharacterBody2D

const SPEED = 800.0
const JUMP_VELOCITY = -400.0
const BULLET_SPEED = 1200.0 # Adjust this to control bullet speed
const SHOOT_INTERVAL = 0.1 # Time in seconds between each shot

var bullet_scene = preload("res://Scenes/Bullet.tscn")

# Variables to handle shooting
var can_shoot = true
var shoot_timer = 0.0

# Ensure the player has a reference to the heart counter (make this variable public if needed)
var heart_counter: Node = null  # Set this to the node containing the heart counter script

func _ready() -> void:
	# Make sure heart_counter is properly assigned
	heart_counter = get_node("/root/control2")  # Adjust path as needed

func _physics_process(delta: float) -> void:
	for index in get_slide_collision_count():
		var collision := get_slide_collision(index)
		var body := collision.get_collider()
		if body != null:
			if body.is_in_group("bubbles"):
				print("nbudabbdk")
				if heart_counter:
					heart_counter.decrease_hearts()

	# Add gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump and shooting
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
		can_shoot = true

	# Shoot bullets constantly while jumping
	if is_on_floor() and can_shoot:
		shoot_timer += delta
		if shoot_timer >= SHOOT_INTERVAL:
			shoot_bullet()
			shoot_timer = 0.05

	# Handle movement
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

		
			
# Function to instantiate and shoot a bullet
func shoot_bullet() -> void:
	var bullet = bullet_scene.instantiate()
	
	# Set bullet's initial position (e.g., slightly in front of the player)
	bullet.position = global_position + Vector2(0, -70) # Adjust the offset based on your player
	
	# Set the bullet's velocity to move upwards
	if bullet.has_method("set_velocity"):
		bullet.set_velocity(Vector2(0, -BULLET_SPEED))
	
	# Add the bullet to the scene
	get_parent().add_child(bullet)
