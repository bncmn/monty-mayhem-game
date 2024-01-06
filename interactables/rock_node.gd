# currentClicks and clicksToDie are defined in the file below.
# addResource() is defined in the file below.
extends "res://interactables/resourceNode.gd"

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		currentClicks += 1
	
		if (currentClicks != clicksToDie):
			PlayerInventory.addResource("rock")
		if (currentClicks == clicksToDie):
			# Add last resource and delete node from the map.
			PlayerInventory.addResource("rock")
			queue_free()
		
		PlayerInventory.printToConsole()
