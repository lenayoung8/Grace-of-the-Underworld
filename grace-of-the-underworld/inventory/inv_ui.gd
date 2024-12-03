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
	for slot in slots:
		var callable = Callable(onSlotClicked)
		callable = callable.bind(slot)
		slot.pressed.connect(callable)
		
# When a slot is clicked, this function plays!
# I tested it with my duck so all the variable names are related to ducks and I lowkey will be keeping that
func onSlotClicked(slot):
	
	var itemVisual = slot.get_node("CenterContainer/Panel/itemDisplay")
	
	if clickType == "RIGHT":
		
		var loadDuck # Declare it
		
		# Add an if-statement and block for each texture we want to compare.
		# Basically, unique if-statement and load for every texture
		if str(itemVisual.texture) == str("<CompressedTexture2D#-9223372005397494473>"): # Duck's Compressed Texture ID
			# Load the duck!
			loadDuck = load("res://test_collectible.tscn") # Make a new load for every texture we want to compare
			textureFound = true
		
		# if tomato texture, then load, texture true
		
		# If we found a texture, then the rest is history!
		# The inv.usedSlots > 0 is to prevent clicking too fast and reaching second-if when duck no exist anymore
		# Now... create the item!
		if textureFound == true and inv.usedSlots > 0:
			# Create the new duck!
			# var loadDuck = load("res://test_collectible.tscn") # Make a new load for every texture we want to compare
			var instantiateDuck = loadDuck.instantiate()
			add_child(instantiateDuck)
			
			# Now let's move the duck to the player's location & move it to its own parent!
			
			#instantiateDuck.reparent(self)
			instantiateDuck.set_global_position(get_node("/root/testWorldEric/Character/Sprite2D").get_global_position())
			#instantiateDuck.position.y -= -10
			instantiateDuck.reparent(get_node("/root")) # Okay so, reparent(self) was the issue that caused the new duck to follow the player's exact movements
			
			# Now, let's remove the duck from the inventory and update the UI!
			# An hour of work just to write these two lines below btw wtf
			
			var player = get_node("/root/testWorldEric/Character")
			# Okay yep, item is nil... WHAT DO WE DO
			# maybe I search through the array to find the... TEXTURE
			# YES! THE TEXTURE! EUREKA!
			# like if an item has a texture similar to this...
			player.inventory.remove(slot.item)
			print(player.inventory.usedSlots)
			
			# Okay now, let's make sure it isn't picked up instantly!
			
			instantiateDuck.get_node("interactable_area/CollisionShape2D").disabled = true
			await get_tree().create_timer(2).timeout # Wait()
			instantiateDuck.get_node("interactable_area/CollisionShape2D").disabled = false
			
			# Finishing touch! Set textureFound to false again so it doesn't backload
			textureFound = false
	
# Updates our inventory item slots!
# Well what does it do specifically...
# Okay, it updates the UI specifically, since inv.slots IS our ui scene and display
func update_slots():
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])

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
	
	## If the input on the GUI is a mouse button...
	
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
			
func open():
	visible = true
	isOpen = true
	
func close():
	visible = false
	isOpen = false
