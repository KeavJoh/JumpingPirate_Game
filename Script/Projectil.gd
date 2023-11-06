extends Node2D

@export var speed = 1
var directionLeft = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(directionLeft):
		self.position.x -= speed
	else:
		self.position.x += speed
