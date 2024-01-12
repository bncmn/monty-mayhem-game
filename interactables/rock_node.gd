# currentClicks, clicksToDie are initialized in the file below.
# addResource() is defined in the file below.
extends "res://interactables/resourceNode.gd"

@onready var rockItem = $"../PlayerUI/PlayerInvGrid/Slot2/Item2"
@onready var ironItem = $"../PlayerUI/PlayerInvGrid/Slot3/Item3"

var rock = "res://assets/placeholders/rock_material_placeholder.png"
var iron = "res://assets/placeholders/metal_placeholder.png"

var rockAdded = false
var ironAdded = false

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and isCollectable:
		currentClicks += 1
		
		print(ironAdded)
		print(rockAdded)
		
		#if PlayerInventory.resources.has("iron") && PlayerInventory.resources.has("rock"):
			#if PlayerInventory.resources["iron"] < 20 || PlayerInventory.resources["rock"] < 20:
				
		if (currentClicks != clicksToDie):
			rollNodeDrop(PlayerInventory.tools.has("pickaxe"))
		if (currentClicks == clicksToDie):
			# Add the last resource.
			rollNodeDrop(PlayerInventory.tools.has("pickaxe"))
			# Delete the node from the scene.
			deleteResource()
		
		#else: 
			#if rockAdded == true:
				#if PlayerInventory.tools.has("pickaxe"):
					#PlayerInventory.resources["rock"] = 2
					#PlayerInventory.resources["iron"] = 0
				#else:
					#PlayerInventory.resources["rock"] = 1
					#PlayerInventory.resources["iron"] = 0
				
			#elif ironAdded == true:
				#if PlayerInventory.tools.has("pickaxe"):
					#PlayerInventory.resources["iron"] = 2
					#PlayerInventory.resources["rock"] = 0
				#else:
					#PlayerInventory.resources["iron"] = 1
					#PlayerInventory.resources["rock"] = 0
		
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
			ironAdded = true
			if PlayerInventory.resources.has("iron"):
				if PlayerInventory.resources["iron"] < 25:
					PlayerInventory.bulkAddResource("iron", 2)
					
		else:
			rockAdded = true
			if PlayerInventory.resources.has("rock"):
				if PlayerInventory.resources["rock"] < 25:
					PlayerInventory.bulkAddResource("rock", 2)
					
	else:
		if (isIron):
			ironAdded = true
			if PlayerInventory.resources.has("iron"):
				if PlayerInventory.resources["iron"] < 25:
					PlayerInventory.addResource("iron")
					
			else: 
				PlayerInventory.resources["iron"] = 1
				
		else:
			rockAdded = true
			if PlayerInventory.resources.has("rock"):
				if PlayerInventory.resources["rock"] < 25:
					PlayerInventory.addResource("rock")
					
			else: 
				PlayerInventory.resources["rock"] = 1
