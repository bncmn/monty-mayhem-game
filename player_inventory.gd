extends Node

# 'resources' is defined as a dictionary with key/value pairs.
# KEY -> the resource, VALUE -> the amount of it the player has.
# Dictionary docs: https://docs.godotengine.org/en/stable/classes/class_dictionary.html
var resources = {}

# 'tools' is defined as a dictionary with key/value pairs.
# KEY -> the tool, VALUE -> a nested dictionary containing the tool's base durability and its remaining durability.
var tools = {}

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

func addTool(item, durability):
	if resources.is_empty() or !resources.has(item):
		# A tool will contain a NESTED DICTIONARY containing its remaining durability and initial durability value.
		# decreaseToolDurability(), defined below, will be in charge of manipulating these values.
		tools[item] = {
			"durabilityRemaining": durability,
			"initialDurability": durability};

func decreaseToolDurability(item):
	if tools.has(item):
		# If the tool has one HP left, the next click will "break" it (remove it from inventory).
		if tools[item]["durabilityRemaining"] == 1:
			print("DEBUG: Tool broke!")
			tools.erase(item)
		# Otherwise, the durability will be decremented.
		else:
			tools[item]["durabilityRemaining"] -= 1

# Get everything in the player's inventory
func printToConsole():
	print("---- DEBUG: Print Inventory ----")
	print(tools)
	print(resources)
