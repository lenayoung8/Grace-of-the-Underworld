extends Node2D

# create child node variables used in carrot plant
@onready var timer = $Timer
@onready var carrotPlant = $Carrot
var stage = 0

# when plant is instantiated: immediately start growth timer & set its grow stage to 0 (seeds)
func _ready():
	timer.start()
	carrotPlant.frame = 0

# "switch" statement basically matches the plant's growth stage to the specific icon it should be displaying
func _process(delta):
	
	match stage:
		0:
			carrotPlant.frame = 0
		1:
			carrotPlant.frame = 1
		2:
			carrotPlant.frame = 2
		3:
			carrotPlant.frame = 3
		4:
			carrotPlant.frame = 4
		5:
			carrotPlant.frame = 5
		6:
			carrotPlant.frame = 6
			
			await get_tree().create_timer(2).timeout # Wait()
			
			var loadDuck = load("res://carrotResource.tscn")
			var instantiateResource = loadDuck.instantiate()
			add_child(instantiateResource)
			
			instantiateResource.set_global_position(carrotPlant.get_global_position())
			#instantiateDuck.position.y -= -10
			instantiateResource.reparent(get_node("/root"))
			
			self.queue_free()
			

# function controls incremented growth, stops when fully grown
func _on_timer_timeout():
	
	if stage < 7: stage += 1
	   
