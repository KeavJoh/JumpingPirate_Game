extends Node2D

var directionLeft = true
var speed = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(directionLeft):
		self.position.x -= speed
	else:
		self.position.x += speed
