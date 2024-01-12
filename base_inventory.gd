extends Node

# 'resources' is defined as a dictionary with key/value pairs.
# KEY -> the resource, VALUE -> the amount of it the player has.
# Dictionary docs: https://docs.godotengine.org/en/stable/classes/class_dictionary.html
var resources = {}

# Functions here are called by the script attached to the node being interacted.
# i.e. tree_node will call PlayerInventory.addResource("tree")
func addResource(item):
	if resources.is_empty() or !resources.has(item):
		resources[item] = 1;
	else:
		resources[item] += 1;

func bulkAddResource(item, amount):
	for n in amount:
		PlayerInventory.addResource(item)

func removeResource(item):
	if resources.is_empty() or !resources.has(item):
		return null
	else:
		resources[item] -= 1;

# Get everything in the player's inventory
func printToConsole():
	print("---- DEBUG: Print Inventory ----")
	print(resources)
