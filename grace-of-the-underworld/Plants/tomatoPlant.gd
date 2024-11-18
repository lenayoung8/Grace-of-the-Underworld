extends Node2D

@onready var timer = $Timer
@onready var tomatoPlant = $Tomato
var stage = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start()
	tomatoPlant.frame = 1


func _process(delta):
	match stage:
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
			


func _on_timer_timeout():
	if stage < 7:
		stage += 1
	   
