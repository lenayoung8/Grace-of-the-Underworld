extends Resource

class_name InvSlot

@export var item:InvItem
@export var amount:int # Used in inv_ui_slot.gd script, where it displays amount of the object
					   # Also used in inventory.gd script, where an item resource's amount is incremented/changed
