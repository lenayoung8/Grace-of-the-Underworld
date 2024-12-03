extends Node2D

func _ready() -> void:
	# Use call_deferred to delay the scene change until the frame is done
	print("Ready. Attempting scene change...")  # Debug print
	call_deferred("_change_scene")

# Function to be called when we call _change_scene deferred
func _change_scene() -> void:
	print("Changing scene to farm.tscn...")
	get_tree().change_scene_to_file("res://farm.tscn")
	
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scripts/characterMovement/characterMovement.tscn")
