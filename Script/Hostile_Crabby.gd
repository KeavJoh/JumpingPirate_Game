extends CharacterBody2D


@export var SPEED = 150.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var runDirection = 1

func _ready():
	checkStatus()

func run():
	$AnimatedSprite2D.play("run")

func _physics_process(delta):
	if(is_on_wall()):
		if(runDirection == -1):
			runDirection = 1
			$AnimatedSprite2D.flip_h = true
		else:
			runDirection = -1
			$AnimatedSprite2D.flip_h = false
	
	velocity.x = runDirection * SPEED
	move_and_slide()

func checkStatus():
	run()

func _on_animated_sprite_2d_animation_finished():
	checkStatus()
