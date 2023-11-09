extends Node2D

@export var speed = 1
var directionLeft = true
var damage = 1
var range = 100
var canMove = true
var posX = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	posX = self.position.x
	$AnimatedSprite2D.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(canMove):
		if(directionLeft):
			self.position.x -= speed
			if(posX - self.position.x > range):
				canMove = false
				explode()
		else:
			self.position.x += speed
			if(self.position.x - posX > range):
				canMove = false
				explode()

func explode():
	$AnimatedSprite2D.play("explosion")
	await get_tree().create_timer(0.3).timeout
	queue_free()

#Hit Player
func _on_area_2d_body_entered(body):
	if(body.is_in_group("Player")):
		canMove = false
		Global.playerDamage(damage)
		explode()
