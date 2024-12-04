extends StaticBody2D

@export var item: InvItem
var player = null

# Function from clicking interactable_area -> Node -> body_entered(etc)
# Essentially, if the body is entered (touched), do execute function!
func _on_interactable_area_body_entered(body):

	if body.has_method("collect"): #CharacterBody2D has collect funciton in script, so this only works w/ CharacterBody2D

		player = body # Since body is the variable that touched the item, and player touched item, body = player, and we assign it to player variable
		
		# If it's NOT empty, then we can add it to the inventory.
		# Issue: inventory perpetually at size of 12
		# Let's fix it with an exported variable int usedSlots!
		# print(player.inventory.slots.size())
		if !(player.inventory.usedSlots >= 12):
			playerCollect()
			
			# Delay... then delete the collected resource?!
			await get_tree().create_timer(0.1).timeout
			self.queue_free()

# Calls the .collect on player (given to us from above function w/ player = body)
func playerCollect():
	player.collect(item)
	
# Notes!
# Click test_collectible -> Inspector -> the green plus -> invItem
# to make it into an invItem resource
# Then, add its texture and move it to the inventory -> items folder as a scene
# And then click test_collectible (or any resource you want to change) again
# and then drag the new saved scene into the Item section under the .gd name of the resource
