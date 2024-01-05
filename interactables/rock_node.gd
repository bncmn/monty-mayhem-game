# currentClicks and clicksToDie are defined in the file below.
extends "res://interactables/resourceNode.gd"

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		currentClicks += 1
		print("DEBUG: Rock node clicked! ", currentClicks, "/", clicksToDie)
		if (currentClicks != clicksToDie):
			addResource("rock", 1)
		if (currentClicks == clicksToDie):
			# Add last resource and delete node from the map.
			addResource("rock", 1)
			queue_free()
		print(PlayerInventory.getAll())
