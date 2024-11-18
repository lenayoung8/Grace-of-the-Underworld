extends Node2D

@onready var timer = $Timer
@onready var carrotPlant = $Carrot
var stage = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start()
	carrotPlant.frame = 1


func _process(delta):
	match stage:
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
			


func _on_timer_timeout():
	if stage < 7:
		stage += 1
	   
