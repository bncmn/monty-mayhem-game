# currentClicks, clicksToDie are initialized in the file below.
# addResource() is defined in the file below.
extends "res://interactables/resourceNode.gd"

@onready var item = $"../PlayerUI/PlayerInvGrid/Slot1/Item1"

var wood = "res://assets/placeholders/wood_placeholder.png"

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and isCollectable:
		currentClicks += 1
		
		item.texture = load(wood)
		item.expand_mode = 1
		item.size = Vector2(80, 80)
		
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
			
		# Adjust weapon durability.
		PlayerInventory.decreaseToolDurability("axe")
		PlayerInventory.printToConsole()
