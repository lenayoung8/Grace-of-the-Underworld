extends CharacterBody2D

# Export is how we create variables that can be EXPORTED
# But they're essentially still variables! varName = thing/object/whatever/
@export var speed = 400
@export var item: InvItem # For example, now item = the Node/Scene InvItem


# Our dictionary! Essentially a map data-structure w/ key,val pair
# https://docs.godotengine.org/en/3.0/classes/class_dictionary.html#class-dictionary
# https://docs.godotengine.org/en/stable/classes/class_dictionary.html
# https://www.reddit.com/r/godot/comments/t2vbzc/can_you_append_new_keyvalue_pairs_to_a_dictionary/
# Insertion syntax is dictionary[key] = value
# or like we did below with "key":value

var walkingAnimDictionary = {
							"left":"walkLeft",
							"right":"walkRight",
							"up":"walkForward",
							"down":"walkForward",
							} 

@export var inventory: Inventory


func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	#var anim_direction = walkingAnimDictionary[input_direction] # Grab the value pair at the movement key pair
	#$Sprite2D/PlayerAnim.play(anim_direction)
	if Input.is_action_pressed("left"):
		$Sprite2D/PlayerAnim.play("walkLeft")
	if Input.is_action_pressed("right"):
		$Sprite2D/PlayerAnim.play("walkRight")
	if Input.is_action_pressed("up"):
		$Sprite2D/PlayerAnim.play("walkBackward")
	if Input.is_action_pressed("down"):
		$Sprite2D/PlayerAnim.play("walkForward")
		
	velocity = input_direction * speed
	
# func _ready(): executes upon loading in!
#				 our "initial" values!
func _ready():
	$Sprite2D/PlayerAnim.play("walkForward")

# How things move... but how??
func _physics_process(_delta):
	get_input()
	move_and_slide()
	
	#if Input.is_action_pressed("ui_left"):
		#velocity.x -= 1.0
	#if Input.is_action_pressed("ui_right"):
		#velocity.x += 1.0
	#if Input.is_action_pressed("ui_up"):
		#velocity.y -= 1.0
	#if Input.is_action_pressed("ui_down"):
		#velocity.y += 1.0
		#
	#move_and_collide(velocity * delta)
	

# If you call player.collect(item) in an object's script,
# it passes that object as an item to this function
# and that's how we add it to our inventory array!
# (by calling inventory.insert(item)... so we now move to inventory.gd script!
func collect(item):
	inventory.insert(item) # Inserting the item into inventory array
