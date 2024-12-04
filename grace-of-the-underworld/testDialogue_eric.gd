extends Sprite2D

func _ready():
	get_node("/root/testWorldEric/testDialogueInteraction").visible = !true

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if get_rect().has_point(to_local(event.position)):
			
			# Okay so, still not sure how to access cross-scenes, BUT the path below works because
			# everything is packaged into a singular test_world_eric scene, so I can access everything
			# by adding it to that scene.
			# Still, it's a finicky method, but we'll see! Also, doing /root/testWorldEric is how
			# we move to the very top of the given scene! It doesn't move us to beyond the given scene though :(
			
			get_node("/root/testWorldEric/testDialogueInteraction/Sprite2D").texture = texture
			
			# This comment is still for the above line lol
			# Okay so, what's cool is that the _input(event) and extends Sprite2D applies to ALL Sprite2D inside the scene
			# so this one script can be clicked for any sprite, and then the clicked sprite2D's texture is passed in!
			# however I think it's easier to just make a separate NPC each time tbh
			# since then you can change their position individually rather than go to a diff scene and change it
			
			if get_node("/root/testWorldEric/testDialogueInteraction").visible == !true:	
				get_node("/root/testWorldEric/testDialogueInteraction").visible = true
				get_node("/root/testWorldEric/testDialogueInteraction/Label").text = str("Woof!")
				print ("You clicked on this Sprite! It works!")
			else:
				get_node("/root/testWorldEric/testDialogueInteraction").visible = !true
