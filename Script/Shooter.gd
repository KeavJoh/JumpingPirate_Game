extends Node2D

@export var minWaitTime = 2
@export var maxWaitTime = 6
@export var lookLeft = true
@export var damageValue = 1
@export var projectilSpeed = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("idle")
	
	if(lookLeft == false):
		$AnimatedSprite2D.flip_h = true
		$FireEffect.position.x *= -1
		$FireEffect.flip_h = true
	
	while(true):
		randomize()
		var awaitTimer = randi_range(minWaitTime, maxWaitTime)
		await get_tree().create_timer(awaitTimer).timeout
		fire()

func fire():
	$FireEffect.visible = true
	$AnimatedSprite2D.play("fire")
	await get_tree().create_timer(0.2).timeout
	$FireEffect.play("fireEffect")
	spawnProjectil()
	await get_tree().create_timer(0.3).timeout
	$FireEffect.visible = false
	$AnimatedSprite2D.play("idle")
	
func spawnProjectil():
	var projectil = preload("res://Actors/Projectil.tscn").instantiate()
	
	projectil.speed = projectilSpeed
	
	if(lookLeft == false):
		projectil.directionLeft = false
		
	projectil.position = self.position
	get_parent().add_child(projectil)
