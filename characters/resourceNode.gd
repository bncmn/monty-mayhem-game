extends StaticBody2D

# Randomize the number of clicks it takes to "harvest" the resource.
var clicksToDie = RandomNumberGenerator.new().randi_range(2,5)
var currentClicks = 0;

func _ready():
	set_process_input(true)

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		currentClicks += 1
		print("DEBUG: Tree clicked! ", currentClicks, "/", clicksToDie)
		# TODO: Write logic for resource harvesting here.
		if (currentClicks != clicksToDie):
			# Every click adds a resource material to the player inventory.
			PlayerInventory.add_item("wood")
		if (currentClicks == clicksToDie):
			PlayerInventory.add_item("wood")
			# Remove resource node from game map once resource has been fully harvested.
			queue_free()
		print("DEBUG:", PlayerInventory.get_inventory())
		
