extends Panel


@onready var text_rect = $Item3


func _get_drag_data(at_position):
	
	set_drag_preview(get_preview())
	
	return text_rect


func _can_drop_data(_pos, data):
	return data is TextureRect


func _drop_data(_pos, data):
	var temp = text_rect.texture
	text_rect.texture = data.texture
	data.texture = temp
	

func get_preview():
	var preview = TextureRect.new()
	
	preview.texture = text_rect.texture
	preview.expand_mode = 1
	preview.size = Vector2(80, 80)
	
	var control = Control.new()
	control.add_child(preview)
	preview.position = -0.5 * preview.size #Cursor postion centered on texture
	
	set_drag_preview(control)
	
	return preview
