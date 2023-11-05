extends Node2D

@export
var hp = 5

func checkDestroy():
	hp -= 1
	if(hp <= 0):
		$AnimatedSprite2D.play("destroy")
		$GPUParticles2D.emitting = true
		await get_tree().create_timer(0.1).timeout
		$AnimatedSprite2D.visible = false
		await get_tree().create_timer(0.3).timeout
		spawnRandomItemAfterDestroyBarrel(self.position)
		queue_free()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#Zufällige Spawnen von Coins oder Diamanten nach erfolgreicher zerstörung von Fässern. 
func spawnRandomItemAfterDestroyBarrel(targetLocation):
	var newItem = null
	
	randomize()
	var randomItemSelection = randi_range(0,2)
	match(randomItemSelection):
		1: newItem = preload("res://Actors/GoldCoin.tscn")
		2: newItem = preload("res://Actors/RedDiamond.tscn")
		
	if(newItem != null):
		var newItemInstance = newItem.instantiate()
		newItemInstance.position = targetLocation
		get_parent().add_child(newItemInstance)
	

func _on_area_2d_area_entered(area):
	if(area.is_in_group("FromPlayer")):
		$AnimatedSprite2D.play("hit")
		checkDestroy()
