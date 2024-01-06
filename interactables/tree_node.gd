# currentClicks, clicksToDie are initialized in the file below.
# addResource() is defined in the file below.
extends "res://interactables/resourceNode.gd"

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		currentClicks += 1
		
		if (currentClicks != clicksToDie):
			if (PlayerInventory.tools.has("axe")):
				PlayerInventory.bulkAddResource("wood", 2)
			else:
				PlayerInventory.addResource("wood")
		if (currentClicks == clicksToDie):
			# Add the last resource.
			if (PlayerInventory.tools.has("axe")):
				PlayerInventory.bulkAddResource("wood", 2)
			else:
				PlayerInventory.addResource("wood")
			# Delete the node from the scene.
			queue_free()
			
		# Adjust weapon durability.
		PlayerInventory.decreaseToolDurability("axe")
		PlayerInventory.printToConsole()
