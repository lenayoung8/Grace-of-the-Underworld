extends Node2D

# Main auto-changes to title screen
func _ready():
	get_tree().change_scene_to_file("res://title_screen.tscn")
