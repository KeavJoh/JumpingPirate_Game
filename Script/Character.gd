extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animSprite = $AnimatedSprite2D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
		# If character jump or fall, run fall or jump animation
		if(velocity.y > 0):
			animSprite.play("fall")
		else:
			animSprite.play("jump")
	#If character not jump or fall, run idle or run animation
	else:
		if(velocity.x == 0):
			animSprite.play("idle")
		else:
			animSprite.play("run")

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		
		#When character switch direction, switch also the character sprite
		if(velocity.x < 0):
			animSprite.flip_h = true
		else:
			animSprite.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
