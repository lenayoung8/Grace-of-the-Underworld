extends Control

# Let's get our player's inventory
@onready var inv: Inventory = preload("res://inventory/playerInventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children() # Grabs all the inventory slots (children of the given path)

var isOpen = false

# Function that activates at the start!
func _ready():
	update_slots()
	close()
	

	inv.update.connect(update_slots)
	update_slots()
	close()
	
# Updates our inventory item slots!
# Well what does it do specifically...
# Okay, it updates the UI specifically, since inv.slots IS our ui scene and display
func update_slots():
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])

func _process(delta):
	if Input.is_action_just_pressed("inventory"):
		if isOpen:
			close()
		else:
			open()
			
	
func open():
	visible = true
	isOpen = true
	
func close():
	visible = false
	isOpen = false
