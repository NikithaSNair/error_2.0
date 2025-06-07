extends CharacterBody2D

const SPEED = 400.0
const JUMP_VELOCITY = -800.0
@onready var sprite_2d = $Sprite2D  # Fixed typo: 'srite_2d' → 'sprite_2d'

# Get gravity from project settings
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if(velocity.x > 1 || velocity.x < -1):
		sprite_2d.animation = "running"
	else:
		sprite_2d.animation = "default"	# Apply gravity if not on the floor
	if not is_on_floor():
		velocity.y += gravity * delta
		sprite_2d.animation = "jumping"
	# Handle jump input
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get left/right input
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 7)

	# Move the character
	move_and_slide()

	# Flip sprite based on movement direction
	var is_left = velocity.x < 0
	sprite_2d.flip_h = is_left
