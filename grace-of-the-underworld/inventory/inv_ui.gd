extends Control

var isOpen = false

func _ready():
	close()
	
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
