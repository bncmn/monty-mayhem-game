extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready(): 
	self.visible = false #Base inventory not visible on ready

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	#If inv not visible, mouse click allows visibility
	if self.is_visible() == false: 
		if event.is_action_pressed("mouseLeft"):
			self.visible = true
	
	#Otherwise (inv is visible), mouse click does not allow visibility
	else:
		if event.is_action_pressed("mouseLeft"):
			self.visible = false
