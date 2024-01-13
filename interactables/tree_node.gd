# currentClicks, clicksToDie are initialized in the file below.
# addResource() is defined in the file below.
extends "res://interactables/resourceNode.gd"

@onready var item = $"../PlayerUI/PlayerInvGrid/Slot1/Item1"

var wood = "res://assets/placeholders/wood_placeholder.png"

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and isCollectable:
		currentClicks += 1
		$collectionArea/woodDust.emitting = true
		
		if PlayerInventory.resources.has("wood"):
			if PlayerInventory.resources["wood"] < 25:
				
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
					deleteResource()
		else:
			if (PlayerInventory.tools.has("axe")):
				PlayerInventory.resources["wood"] = 2
			else:
				PlayerInventory.resources["wood"] = 1
			
		# Adjust weapon durability.
		PlayerInventory.decreaseToolDurability("axe")
		PlayerInventory.printToConsole()
