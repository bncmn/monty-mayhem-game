extends StaticBody2D

func _ready():
	set_process_input(true)

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		PlayerInventory.addTool("axe")
		queue_free()
		print("DEBUG: Player picked up axe!")
		print(PlayerInventory.getAll())
