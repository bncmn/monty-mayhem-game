# currentClicks, clicksToDie are initialized in the file below.
# addResource() is defined in the file below.
extends "res://interactables/resourceNode.gd"

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		currentClicks += 1
		
		print("DEBUG: Tree node clicked! ", currentClicks, "/", clicksToDie)
		if (currentClicks != clicksToDie):
			if (PlayerInventory.tools.has("axe")):
				addResource("wood", 2)
			else:
				addResource("wood", 1)
		if (currentClicks == clicksToDie):
			# Add last resource and delete node from the map.
			if (PlayerInventory.tools.has("axe")):
				addResource("wood", 2)
			else:
				addResource("wood", 1)
			queue_free()
		print(PlayerInventory.getAll())
