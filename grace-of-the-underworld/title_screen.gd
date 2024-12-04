extends Node2D

# Two buttons, two different signals
func _on_button_pressed():
	get_tree().change_scene_to_file("res://TileMaps/Farm.tscn")

func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://test_world_eric.tscn")
