extends CanvasLayer


@onready var craft = $"../PlayerUI/CraftUI"
@onready var wall = $WallUI
@onready var tool = $ToolUI


func _ready():
	tool.close()
	wall.close()


func _on_tool_open_pressed():
	tool.open()
	craft.close()


func _on_wall_open_pressed():
	wall.open()
	craft.close()


func _on_tool_close_pressed():
	tool.close()
	craft.open()


func _on_wall_close_pressed():
	wall.close()
	craft.open()


func _on_wall_open_from_tool_pressed():
	wall.open()
	tool.close()
