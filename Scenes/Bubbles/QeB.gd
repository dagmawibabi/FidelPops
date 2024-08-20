extends CharacterBody2D

var sprite_variants = [
	preload("res://Assets/Letters/22.png"),
	preload("res://Assets/Letters/23.png"),
	preload("res://Assets/Letters/24.png"),
	preload("res://Assets/Letters/25.png"),
	preload("res://Assets/Letters/26.png"),
	preload("res://Assets/Letters/27.png"),
	preload("res://Assets/Letters/28.png"),
]

# Set the bounds for random positioning
var min_x = -360
var max_x = 730
var min_y = -190
var max_y = 0

# Set the range for random scaling (size variation)
var min_scale = 0.05
var max_scale = 0.3
var cur_scale = 0.0

const JUMP_VELOCITY = -800.0
const SCALE_STEP = 0.001
const MAX_SCALE = 0.4
const TARGET_OBJECT_NAME = "Bubbles"

func _ready() -> void:
	_random_identity()
	# Connect the animation_finished signal of AnimatedSprite2D to a function
	#$AnimatedSprite2D.connect("animation_finished", self, "_on_animation_finished")
	$AnimatedSprite2D.connect("animation_finished", self._on_animation_finished)
	$AnimatedSprite2D.visible = false
	# Optional: Connect collision signals if using Area2D or similar
	# If using Area2D, uncomment the following line:
	# connect("body_entered", self, "_on_body_entered")

func _random_identity() -> void:
	var random_position = Vector2(randf_range(min_x, max_x), randf_range(min_y, max_y))
	position = random_position # Assign the random position
	
	var random_scale = randf_range(min_scale, max_scale) # Generate a random scale
	scale = Vector2(random_scale, random_scale) # Apply the random scale
	cur_scale = random_scale
	
	# Assign a random texture to the character's Sprite2D node
	var sprite = get_node("Sprite2D") # Ensure this node exists and is named correctly
	var random_texture = sprite_variants[randi() % sprite_variants.size()] # Pick a random texture
	sprite.texture = random_texture # Set the texture to the selected PNG

func _physics_process(delta: float) -> void:
	if cur_scale >= MAX_SCALE:
		play_explosion_animation()
	else:
		if not is_on_floor():
			velocity += get_gravity() * delta
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			velocity.x = randf_range(-300.0, 300.0)
		move_and_slide()

	for index in get_slide_collision_count():
		var collision := get_slide_collision(index)
		var body := collision.get_collider()
		if body != null:
			if body.is_in_group("Bullets"):
				scale_up()
			#if body.name.begins_with("@CharacterBody2D@"):
				#scale_up()
			#if(body.name != "CharacterBody2D" && body.name != "StaticBody2D" && body.name != "StaticBody2D2" && body.name != "StaticBody2D3" && body.name != "StaticBody2D4"):
				#scale_up()			

func _on_body_entered(body: Node) -> void:
	print(body.name)
	if body.name == TARGET_OBJECT_NAME:
		scale_up()

func scale_up() -> void:
	ScoreManager.increase_score(1)
	if cur_scale < MAX_SCALE:
		cur_scale += SCALE_STEP
		if cur_scale > MAX_SCALE:
			cur_scale = MAX_SCALE
		scale = Vector2(cur_scale, cur_scale)
		
func play_explosion_animation() -> void:
	var sprite = $Sprite2D
	sprite.visible = false # Hide the main sprite during the explosion
	var anim = $AnimatedSprite2D
	anim.visible = true
	anim.play() # Play the explosion animation
	if !$AnimatedSprite2D.is_playing():
		queue_free()

# This function will be called when the explosion animation finishes
func _on_animation_finished() -> void:
	ScoreManager.increase_score(5)
	queue_free() # Free the object after the explosion animation is done
