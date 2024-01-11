extends Label


func _process(delta):
	if PlayerInventory.resources.has("rock"):
		text = str(PlayerInventory.resources["rock"])
