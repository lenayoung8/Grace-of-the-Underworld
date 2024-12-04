extends Node2D

# CREATE ALL GAME-TIME VARIABLES
@onready var timer = $"GameTime"
var gameTime = 0

# create useful constants used to calculate game time
const minsPerDay = 1440
const minsPerHour = 60
const numInGameMinsPerRealMin = (2 * PI) / minsPerDay

# CREATE ALL CROP VARIABLES
@onready var tileMap = $TileMap
const dirtID = 1 # used later to identify if a tile is dirt

# preload crop scenes into const variables to place later
const carrotPlant = preload("res://Plants/carrotPlant.tscn")
const tomatoPlant = preload("res://Plants/tomatoPlant.tscn")
 
# CREATE ALL DAY/NIGHT CYCLE VARIABLES
@onready var darkness = get_node("Ambient")
@onready var light = get_node("Persephone/NightLight")

# define color schemes for various times of day
var colorScheme = {
	0: Color8(40, 40, 40),
	1: Color8(60, 60, 60),
	2: Color8(80, 80, 80),
	3: Color8(100, 100, 100),
	4: Color8(120, 120, 120),
	5: Color8(140,140,140),
	6: Color8(160,160,160),
	7: Color8(180, 180, 180),
	8: Color8(200, 200, 200),
	9: Color8(220, 220, 200),
	10: Color8(240, 240, 240),
}

# define light schemes depending on time of day
var lightSchemes = {
	0: 0.8,
	1: 0.7,
	2: 0.6,
	3: 0.5,
	4: 0.4,
	5: 0.3,
	6: 0.2,
	7: 0.1,
	8: 0,
}

# RUN FUNCTIONS AT START OF SCENE
func _ready() -> void:
	
	timer.start()
	
# FUNCTION HANDLES IN-GAME TIME & DAY/NIGHT CYCLE PROCESSES
func _process(delta: float) -> void:
	
	# update game time
	gameTime += delta * numInGameMinsPerRealMin
	
	# calculate current hour
	var totalMins = int(gameTime / numInGameMinsPerRealMin)
	var dayMins = int(totalMins % minsPerDay)
	var hour = int((dayMins / minsPerHour) & 24)
	
	# change color & light schemes based on in-game hour
	
	# 12AM - 6AM
	if (hour >= 0 && hour < 6):
		
		darkness.color = colorScheme[0]
		light.energy = lightSchemes[0]
		
	# 7AM - 10AM
	elif (hour >= 7 && hour < 10):
		
		darkness.color = colorScheme[4]
		light.energy = lightSchemes[4]
		
	# 11AM - 5PM
	elif (hour >= 11 && hour < 17):
		
		darkness.color = colorScheme[8]
		light.energy = lightSchemes[8]
				
	# 6M - 8PM
	elif (hour >= 18 && hour < 20):
		
		darkness.color = colorScheme[5]
		light.energy = lightSchemes[5]
				
	# 9PM - 12AM
	elif (hour >= 20 && hour < 24):
		
		darkness.color = colorScheme[2]
		light.energy = lightSchemes[2]
	
# function handles mouse input (clicks)
func _unhandled_input(event):
	
	if event is InputEventMouseButton and event.pressed:
		
		# first: get mouse position	
		var mousePosition = get_global_mouse_position()
		
		# then: convert mouse pos to local pos
		var localPosition = tileMap.to_local(mousePosition)
		
		# last: convert local pos to tilemap coords
		var tilePosition = tileMap.local_to_map(localPosition)
		
		# now, we want to get the id of the tile we clicked on
		var layer = tileMap.get_node("CollisionTiles")
		var srcID = layer.get_cell_source_id(tilePosition)
		
		# if it matches the dirt id, we can plant on it!
		if (srcID == dirtID):
				
			# if left mouse button is pressed -> add tomato plant
			if event.button_index == MOUSE_BUTTON_LEFT: add_plant(tomatoPlant)
				
			# if right mouse button is pressed -> add carrot plant
			elif event.button_index == MOUSE_BUTTON_RIGHT: add_plant(carrotPlant)

# function used to create instances of plants at mouse click
func add_plant(plant_scene):
	
	var plantInstance = plant_scene.instantiate()
	
	plantInstance.position = get_global_mouse_position()
	
	add_child(plantInstance);


func _on_game_time_timeout() -> void:
	
	pass # Replace with function body.
