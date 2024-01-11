extends Label


func _process(delta):
	if PlayerInventory.resources.has("iron"):
		text = str(PlayerInventory.resources["iron"])
