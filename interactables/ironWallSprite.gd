extends Sprite2D

func _process(delta):
	var mouse_tile = Global.tilemap.local_to_map(get_global_mouse_position())
	var local_pos = Global.tilemap.map_to_local(mouse_tile)
	var world_pos = Global.tilemap.to_global(local_pos)
	
	self.texture = load("res://assets/inventory/iron_wall_icon.png")
	self.expand_mode = 1
	self.size = Vector2(64, 64)
	global_position = world_pos

func _unhandled_input(event):
	if event is InputEventMouseButton && event.pressed && event.button_index == MOUSE_BUTTON_LEFT:
		set_process(false)
		set_process_unhandled_input(false)
