extends Panel


@onready var item = $Item2


func _get_drag_data(at_position):
	
	set_drag_preview(get_preview())
	
	return item


func _can_drop_data(_pos, data):
	return data is TextureRect


func _drop_data(_pos, data):
	var temp = item.texture
	item.texture = data.texture
	data.texture = temp
	
	if PlayerInventory.resources.has("rock"):
		if PlayerInventory.resources["rock"] > 0:
			PlayerInventory.removeResource("rock")
		else: 
			PlayerInventory.resources["rock"] = 0
	
	PlayerInventory.printToConsole()
	

func get_preview():
	var preview = TextureRect.new()
	
	preview.texture = item.texture
	preview.expand_mode = 1
	preview.size = Vector2(80, 80)
	
	var control = Control.new()
	control.add_child(preview)
	preview.position = -0.5 * preview.size #Cursor postion centered on texture
	
	set_drag_preview(control)
	
	return preview
