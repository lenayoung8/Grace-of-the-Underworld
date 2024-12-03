extends Button

@export var item: InvItem
@onready var itemVisual: Sprite2D = $CenterContainer/Panel/itemDisplay
@onready var amount_text: Label = $CenterContainer/Panel/Label # Set amount_text = to the label we have in our inv_ui_slot scene!
															   # Just like Roblox when you find a path and set a var to that path lol
# slot here is any variable! It's now linked to InvSlot
# Has the same name as the slot in inventory.gd, but are not the same variables!
# It's just whateverWeWantToCallIt : theActualThing
func update(slot: InvSlot):
	if !slot.item: # If the item doesn't exist in the slot, then we can't have the UI showing!
		itemVisual.visible = false
		amount_text.visible = false 
		itemVisual.texture = null
	else: # But if it is... get the texture for the UI and number tracker and etc.!
		itemVisual.visible = true
		itemVisual.texture = slot.item.texture
		
		# Just to make things prettier - only displays amount if there's more than 1 of that item in the stack
		if slot.amount > 1:
			amount_text.visible = true
			
		amount_text.text = str(slot.amount) # slot.amount a resource variable we made in slot resource in
											# inv_slot.gd
											


#func _on_pressed():
	#
	##print (itemVisual.texture)
	##print (" ")
	##print (str("res://art/test/duck.png"))
	#
	## First, check the current input event type	
	#
		#
	## Duck Resource
	#if str(itemVisual.texture) == str("<CompressedTexture2D#-9223372005397494473>"): # Duck's Compressed Texture ID
		#
		## Create the new duck!
		#var loadDuck = load("res://test_collectible.tscn")
		#var instantiateDuck = loadDuck.instantiate()
		#add_child(instantiateDuck)
		#
		## Now let's move the duck to the player's location & move it to its own parent!
		#
		##instantiateDuck.reparent(self)
		#instantiateDuck.set_global_position(get_node("/root/testWorldEric/Character/Sprite2D").get_global_position())
		##instantiateDuck.position.y -= -10
		#instantiateDuck.reparent(get_node("/root")) # Okay so, reparent(self) was the issue that caused the new duck to follow the player's exact movements
		#
		## Okay now, let's make sure it isn't picked up instantly!
		#
		#instantiateDuck.get_node("interactable_area/CollisionShape2D").disabled = true
		#await get_tree().create_timer(2).timeout
		#instantiateDuck.get_node("interactable_area/CollisionShape2D").disabled = false


#func _on_gui_input(event: InputEvent):
#
	## If the input on the GUI is a mouse button...
	#if event.is_pressed() and event is InputEventMouseButton:
		#
		## Then we check which one it is!
		#match event.button_index:
			#
			## For left - we "select" it!
			#
			## For right - we discard from inventory!
			#MOUSE_BUTTON_RIGHT:
				#
				#if str(itemVisual.texture) == str("<CompressedTexture2D#-9223372005397494473>"): # Duck's Compressed Texture ID
		#
					## Create the new duck!
					#var loadDuck = load("res://test_collectible.tscn")
					#var instantiateDuck = loadDuck.instantiate()
					#add_child(instantiateDuck)
					#
					## Now let's move the duck to the player's location & move it to its own parent!
					#
					##instantiateDuck.reparent(self)
					#instantiateDuck.set_global_position(get_node("/root/testWorldEric/Character/Sprite2D").get_global_position())
					##instantiateDuck.position.y -= -10
					#instantiateDuck.reparent(get_node("/root")) # Okay so, reparent(self) was the issue that caused the new duck to follow the player's exact movements
					#
					## Now, let's remove the duck from the inventory and update the UI!
					## An hour of work just to write these two lines below btw wtf
					#
					#var player = get_node("/root/testWorldEric/Character")
					## Okay yep, item is nil... WHAT DO WE DO
					## maybe I search through the array to find the... TEXTURE
					## YES! THE TEXTURE! EUREKA!
					## like if an item has a texture similar to this...
					#player.inventory.remove(item)
					#print(player.inventory.usedSlots)
					#
					## Okay now, let's make sure it isn't picked up instantly!
					#
					#instantiateDuck.get_node("interactable_area/CollisionShape2D").disabled = true
					#await get_tree().create_timer(2).timeout
					#instantiateDuck.get_node("interactable_area/CollisionShape2D").disabled = false
					
