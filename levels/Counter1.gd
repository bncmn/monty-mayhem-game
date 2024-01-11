extends Label


func _process(delta):
	if PlayerInventory.resources.has("wood"):
		text = str(PlayerInventory.resources["wood"])
