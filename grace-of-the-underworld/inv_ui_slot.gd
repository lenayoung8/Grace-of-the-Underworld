extends Panel
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
	else: # But if it is... get the texture for the UI and number tracker and etc.!
		itemVisual.visible = true
		itemVisual.texture = slot.item.texture
		
		# Just to make things prettier - only displays amount if there's more than 1 of that item in the stack
		if slot.amount > 1:
			amount_text.visible = true
			
		amount_text.text = str(slot.amount) # slot.amount a resource variable we made in slot resource in
											# inv_slot.gd