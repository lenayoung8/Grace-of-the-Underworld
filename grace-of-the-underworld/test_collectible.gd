extends StaticBody2D

@export var item: InvItem
var player = null

# Click test_collectible -> Inspector -> the green plus -> invItem
# to make it into an invItem resource
# Then, add its texture and move it to the inventory -> items folder as a scene
# And then click test_collectible (or any resource you want to change) again
# and then drag the new saved scene into the Item section under the .gd name of the resource

# Function from clicking interactable_area -> Node -> body_entered(etc)
# Essentially, if the body is entered (touched), do execute function!
func _on_interactable_area_body_entered(body):
	#if body.has_method("player"): # Okay, I commented this out since I think the tutorial has a "player" method
								   # attached to the character, but... I don't! so no need for that yet
								   # although definitely will need to later on just so it doesn't interact with other things
	#print(body)	
	player = body # Since body is the variable that touched the item, and player touched item, body = player, and we assign it to player variable
	
	# If it's NOT empty, then we can add it to the inventory.
	# Issue: inventory perpetually at size of 12
	# Let's fix it with an exported variable int usedSlots!
	# print(player.inventory.slots.size())
	if !(player.inventory.usedSlots >= 12):
		playerCollect()
		
		# Delay... then delete the collected resource?!
		await get_tree().create_timer(0.1).timeout
		#self.reparent(player)
		self.queue_free()
		
func playerCollect():
	player.collect(item)
