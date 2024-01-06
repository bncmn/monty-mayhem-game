extends Panel


@onready var texture_rect = $ItemTextureRect


func _get_drag_data(at_position):
	
	set_drag_preview(get_preview())
	
	return texture_rect


func _can_drop_data(at_position, data):
	return data is TextureRect


func _drop_data(at_position, data):
	var temp = texture_rect.texture
	texture_rect.texture = data.texture_rect
	data.texture = temp
	

func get_preview():
	var preview = TextureRect.new()
	
	preview.texture = texture_rect.texture
	preview.expand_mode = 1
	preview.size = Vector2(80, 80)
	
	var control = Control.new()
	control.add_child(preview)
	preview.position = -0.5 * preview.size #Cursor postion centered on texture
	
	set_drag_preview(control)
	#texture_rect.texture = null
	
	return preview
