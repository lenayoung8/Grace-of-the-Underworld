extends Node2D

# create child node variables used in tomato plant
@onready var timer = $Timer
@onready var tomatoPlant = $Tomato
var stage = 0 # start plant at first growth stage

# when plant is instantiated: immediately start growth timer & set its displayed icon to stage 0 (seeds)
func _ready():
	timer.start()
	tomatoPlant.frame = 0


# "switch" statement basically matches the plant's growth stage to the specific icon it should be displaying
func _process(delta):
	
	match stage:
		0:
			tomatoPlant.frame = 0
		1:
			tomatoPlant.frame = 1
		2:
			tomatoPlant.frame = 2
		3:
			tomatoPlant.frame = 3
		4:
			tomatoPlant.frame = 4
		5:
			tomatoPlant.frame = 5
		6:
			tomatoPlant.frame = 6
			

# function controls incremented growth, stops when fully grown
func _on_timer_timeout():
	
	if stage < 7: stage += 1
