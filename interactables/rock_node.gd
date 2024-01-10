# currentClicks, clicksToDie are initialized in the file below.
# addResource() is defined in the file below.
extends "res://interactables/resourceNode.gd"

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and isCollectable:
		currentClicks += 1
	
		if (currentClicks != clicksToDie):
			rollNodeDrop(PlayerInventory.tools.has("pickaxe"))
		if (currentClicks == clicksToDie):
			# Add the last resource.
			rollNodeDrop(PlayerInventory.tools.has("pickaxe"))
			# Delete the node from the scene.
			deleteResource()
			
		# Adjust weapon durability.
		PlayerInventory.decreaseToolDurability("pickaxe")
		PlayerInventory.printToConsole()

# This function determines if the rock node will drop iron or stone.
# This function is run each time the player clicks the rock node.
func rollNodeDrop(hasPickaxe):
	# The statement below randomly determines if the node will drop iron or stone during a specific click.
	# The number of [false/true]s in the array determines the probability that one of them is selected.
	# i.e. 3 trues == 30% chance of an iron drop.
	var isIron = [false, false, false, false, false, false, false, true, true, true][randi() % 10]
	
	if (hasPickaxe):
		if (isIron):
			PlayerInventory.bulkAddResource("iron", 2)
		else:
			PlayerInventory.bulkAddResource("rock", 2)
	else:
		if (isIron):
			PlayerInventory.addResource("iron")
		else:
			PlayerInventory.addResource("rock")
