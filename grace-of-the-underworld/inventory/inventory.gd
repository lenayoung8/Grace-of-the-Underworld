extends Resource

class_name Inventory

signal update

# Export the variable into the inspector page
# the : initializes slots to Array[InvSlot]
@export var slots:Array [InvSlot]
@export var usedSlots: int # My own little export variable! Tracks number of used slots

# Essentially, this function tracks the amount of items
# in a given slot after it is inserted into the inventory
func insert(item: InvItem):
	
	# Think of itemSlots as an iterator for a set - var itemSlots = ...
	# essentially goes through the entire inventory and checks if the item is already inside
	# (i.e. we found the object in inventory & something is already inside),
	# then we can increment the amount of items in that slot by 1
	
	var emptySlots = slots.filter(func(slot): return slot.item == null)
	if !emptySlots.is_empty():
		emptySlots[0].item = item
		emptySlots[0].amount = 1
		usedSlots += 1
			
	update.emit() # Updates the inventory(?)

# Function that removes an item from the inventory!
# Same as the insert item function, but we decrement instead! 

func remove(item: InvItem):
	var itemSlots = slots.filter(func(slot): return slot.item == item)
	if !slots.is_empty():
		slots.remove_at(0)

		usedSlots -= 1
		
	update.emit()
	print("Test") # I can't believe my hour of work is three simple lines wtf
