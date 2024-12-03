extends Resource

class_name Inventory

signal update # I actually dk

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
	
	# Below is code to make each slot hold multiple of the same items!
	# I've just commented it out to work on dropping items from inventory easier!
	
	#var itemSlots = slots.filter(func(slot): return slot.item == item)
	#if !itemSlots.is_empty():
		#itemSlots[0].amount += 1 # itemSlots[0] as itemSlots returns an array of all slots w/ the given item,
								 ## so we increment the first one (assumed to be not full... maybe need to add that clause)
		#
	## Else, if we couldn't find the item anywhere in inventory,
	## we use emptySlots to check if there are any empty slots available
	## Then, if there is, we set the first emptmy slot to the item,
	## and initialize the amount to 1 (since it's the first appearance of the item!)
	## Think of this like Superball LMAO
	#else:
	
	# uncomment the above and index all code below by one line up until the update.emit() (which updates the inv after every action)
	# to add back the multi-stacking!
	
	var emptySlots = slots.filter(func(slot): return slot.item == null)
	if !emptySlots.is_empty():
		emptySlots[0].item = item
		emptySlots[0].amount = 1
		usedSlots += 1
			
	
	
	update.emit() # Updates the inventory(?)
	
func remove(item: InvItem):
	var itemSlots = slots.filter(func(slot): return slot.item == item)
	if !slots.is_empty():
		slots.remove_at(0)
		#itemSlots[0].amount = 0
		usedSlots -= 1
		
	
	update.emit()
	print("Test") # I can't believe my hour of work is three simple lines wtf
