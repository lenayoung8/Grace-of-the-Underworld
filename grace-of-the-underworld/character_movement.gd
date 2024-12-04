extends CharacterBody2D

# Export is how we create variables that can be EXPORTED
# But they're essentially still variables! varName = thing/object/whatever/
@export var speed = 400
@export var item: InvItem # For example, now item = the Node/Scene InvItem
@export var inventory: Inventory

# Signal whenever an input is obtained!
# We check what the input is, and then change the animation to that input!

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")

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

# This signal funciton checks every frame!
# move_and_slide() is built-in to move the player based off velocity!

func _physics_process(_delta):
	get_input()
	move_and_slide()
	

# If you call player.collect(item) in an object's script,
# it passes that object as an item to this function
# and that's how we add it to our inventory array!
# (by calling inventory.insert(item)... so we now move to inventory.gd script!
func collect(item):
	inventory.insert(item) # Inserting the item into inventory array
