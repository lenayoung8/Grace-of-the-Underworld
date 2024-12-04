extends Control

# Let's get our player's inventory
@onready var inv: Inventory = preload("res://inventory/playerInventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children() # Grabs all the inventory slots (children of the given path)

var clickType
var isOpen = false
var textureFound = false

# Function that activates at the start!
func _ready():
	connectSlots()
	inv.update.connect(update_slots)
	update_slots()
	close()
	
func connectSlots():
	print("Connected")
	for slot in slots:
		var callable = Callable(onSlotClicked)
		callable = callable.bind(slot)
		slot.pressed.connect(callable)
		
# When a slot is clicked, this function plays!
# I tested it with my duck so all the variable names are related to ducks and I lowkey will be keeping that
func onSlotClicked(slot):
	
	var itemVisual = slot.get_node("CenterContainer/Panel/itemDisplay")
	print("itemVisual")
	await get_tree().create_timer(.05).timeout # Wait()

	if clickType == "RIGHT":
		
		var loadDuck # Declare it
		print(itemVisual.texture
		)
		
		# Add an if-statement and block for each texture we want to compare.
		# Basically, unique if-statement and load for every texture
		# Now how do we avoid finding the texture every time... what about metadata (for future reference)?! :D
		
		if str(itemVisual.texture) == str("<CompressedTexture2D#-9223372005380717256>" or str(itemVisual.texture) == str("<CompressedTexture2D#-9223372001840724656>")): # Duck's Compressed Texture ID
			# Load the duck!
			loadDuck = load("res://test_collectible.tscn") # Make a new load for every texture we want to compare
			textureFound = true
		
		if str(itemVisual.texture) == str("<CompressedTexture2D#-9223372005380717256>" or str(itemVisual.texture) == str("<CompressedTexture2D#-9223371884668646237>")): # Tomato's Compressed Texture ID
			# Load the tomato!
			loadDuck = load("res://tomatoResource.tscn") # Make a new load for every texture we want to compare
			textureFound = true
	
		# If we found a texture, then the rest is history!
		# The inv.usedSlots > 0 is to prevent clicking too fast and reaching second-if when duck no exist anymore
		# Now... create the item!
		print(inv.usedSlots)
		
		if textureFound == true and inv.usedSlots > 0:
			
			print("Hi!")

			var instantiateDuck = loadDuck.instantiate()
			add_child(instantiateDuck)
			
			# Now let's move the duck to the player's location & move it to its own parent!
			# Make sure to parent to /root or the new item will follow the player's movement haha
			
			instantiateDuck.set_global_position(get_node("/root/testWorldEric/Character/Sprite2D").get_global_position())
			instantiateDuck.reparent(get_node("/root"))
			
			# Now, let's remove the duck from the inventory and update the UI!
			# An hour of work just to write these two lines below btw wtf
			
			var player = get_node("/root/testWorldEric/Character")
	
			player.inventory.remove(slot.item)
			print(player.inventory.usedSlots)
			
			# Okay now, let's make sure it isn't picked up instantly!
			
			instantiateDuck.get_node("interactable_area/CollisionShape2D").disabled = true
			await get_tree().create_timer(2).timeout # Wait()
			instantiateDuck.get_node("interactable_area/CollisionShape2D").disabled = false
			
			# Finishing touch! Set textureFound to false again so it doesn't backload
			# Also do a wait statement to stop spam
			
			textureFound = false
			
	
# Updates our inventory item slots!
func update_slots():
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])

# Process takes inputs
func _process(delta):
	if Input.is_action_just_pressed("inventory"):
		if isOpen:
			update_slots()
			close()
		else:
			update_slots()
			open()

# Is a signal function!
# So it auto-plays without calling whenever an input is made... such as mouse clicks!
func _input(event: InputEvent):
	
	await get_tree().create_timer(.1).timeout # Wait()
	
	# If the input on the GUI is a mouse button...
	
	if event.is_pressed() and event is InputEventMouseButton:
		
		# Then we check which one it is!
		match event.button_index:
			
			# For left - we "select" it!
			MOUSE_BUTTON_LEFT:
				clickType = "LEFT"
			# For right - we discard from inventory!
			MOUSE_BUTTON_RIGHT:
				clickType = "RIGHT"
				
		print (clickType)

# Opens and closes the GUI 
func open():
	visible = true
	isOpen = true
	
func close():
	visible = false
	isOpen = false
