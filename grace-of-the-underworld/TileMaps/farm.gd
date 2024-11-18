extends Node2D

const carrotPlant = preload("res://Plants/carrotPlant.tscn")
const tomatoPlant = preload("res://Plants/tomatoPlant.tscn")

# This function will handle input events
func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			# Check if the left mouse button is pressed
			if event.button_index == MOUSE_BUTTON_LEFT:
				print("Left click detected!")
				add_plant(tomatoPlant)
			
			# Check if the right mouse button is pressed
			elif event.button_index == MOUSE_BUTTON_RIGHT:
				print("Right click detected!")
				add_plant(carrotPlant)

# Function to instantiate and add the plant to the scene at the mouse position
func add_plant(plant_scene):
	var plant_instance = plant_scene.instantiate()
	plant_instance.position = get_global_mouse_position()
	print("Spawning plant at: ", plant_instance.position)  # Debug line to see where the plant is being placed
	add_child(plant_instance)
