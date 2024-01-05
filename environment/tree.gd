extends StaticBody2D

func _ready():
	set_process_input(true)

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		# TODO: Write logic for resource harvesting here.
		print("DEBUG: Tree clicked!")
