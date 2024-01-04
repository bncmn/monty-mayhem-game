extends StaticBody2D

var clicksToDie = RandomNumberGenerator.new().randi_range(2,5)
var currentClicks = 0;

func _ready():
	set_process_input(true)

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		# TODO: Write logic for resource harvesting here.
		if (currentClicks != clicksToDie):
			PlayerInventory.add_item("wood")
			print(PlayerInventory.get_inventory())
			currentClicks += 1
		print("DEBUG: Tree clicked! ", currentClicks, "/", clicksToDie)
		if (currentClicks == clicksToDie):
			queue_free()
		
