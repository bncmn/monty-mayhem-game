# currentClicks, clicksToDie are initialized in the file below.
# addResource() is defined in the file below.
extends "res://interactables/resourceNode.gd"

@onready var slot = [$"../PlayerUI/PlayerInvGrid/Slot1/Item1", $"../PlayerUI/PlayerInvGrid/Slot2/Item2",\
$"../PlayerUI/PlayerInvGrid/Slot3/Item3", $"../PlayerUI/PlayerInvGrid/Slot4/Item4", $"../PlayerUI/PlayerInvGrid/Slot5/Item5"]

var iron = "res://assets/placeholders/metal_placeholder.png"
var rock = "res://assets/placeholders/rock_material_placeholder.png"
var wood = "res://assets/placeholders/wood_placeholder.png"

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and isCollectable:
		currentClicks += 1
		
		for item in slot:
			if item.texture == load(wood):
				break
			elif  item.texture != load(iron) && item.texture != load(rock):
				item.texture = load(wood)
				item.expand_mode = 1
				item.size = Vector2(80, 80)
				break
		
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
