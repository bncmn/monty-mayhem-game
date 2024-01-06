extends StaticBody2D

# Randomize the number of clicks it takes to "harvest" the resource.
var clicksToDie = RandomNumberGenerator.new().randi_range(2,5)

# Track the number of times the node has been clicked.
var currentClicks = 0;

func _ready():
	set_process_input(true)

func addResource(resource, amount):
	for n in amount:
		PlayerInventory.addResource(resource)
