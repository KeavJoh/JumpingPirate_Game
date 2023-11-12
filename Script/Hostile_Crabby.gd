extends CharacterBody2D


@export var SPEED = 150.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var hostileHp = 3
@export var hostileDamage = 1
var runDirection = 1
var isDead = false
var playerIsInDamageZone = false

func _ready():
	checkStatus()

func run():
	$AnimatedSprite2D.play("run")
	
func attack():
	if(!isDead):
		runDirection = 0
		await get_tree().create_timer(1).timeout
		if(playerIsInDamageZone and !isDead):
			$AnimatedSprite2D.play("attack")
			await get_tree().create_timer(0.2).timeout
			Global.playerDamage(hostileDamage)
			runDirection = 1
		else:
			runDirection = 1
			
		checkStatus()

func _physics_process(delta):
	if(!isDead):
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
	if(hostileHp == 0):
		isDead = true
		runDirection = 0
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.play("dead")
		await get_tree().create_timer(3).timeout
		queue_free()
	else:
		if(playerIsInDamageZone):
			attack()
		else:
			run()

func _on_animated_sprite_2d_animation_finished():
	if(!isDead):
		checkStatus()

#Hit
func _on_area_2d_area_entered(area):
	if(!isDead and area.is_in_group("FromPlayer")):
		hostileHp -= 1
		runDirection = 0
		$AnimatedSprite2D.play("hit")
		await get_tree().create_timer(1).timeout
		runDirection = 1
		checkStatus()


func _on_area_2d_body_entered(body):
	if(!isDead and body.is_in_group("Player")):
		playerIsInDamageZone = true
		checkStatus()


func _on_area_2d_body_exited(body):
	if(!isDead and body.is_in_group("Player")):
		playerIsInDamageZone = false
		checkStatus()
