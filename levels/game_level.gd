extends Node2D

@onready var baseInv = $BaseUI/BaseInvUI
@onready var craftMenu = $PlayerUI/CraftUI
@onready var toolMenu = $CraftMenuUI/ToolUI
@onready var wallMenu = $CraftMenuUI/WallUI



func _on_base_inv_ui_closed():
	get_tree().paused = false


func _on_base_inv_ui_opened():
	get_tree().paused = true


func _on_player_inv_area_mouse_entered():
	get_tree().paused = true


func _on_player_inv_area_mouse_exited():
	if baseInv.isOpen:
		get_tree().paused = true
	else: 
		get_tree().paused = false


func _on_craft_area_mouse_entered():
	get_tree().paused = true


func _on_craft_area_mouse_exited():
	if baseInv.isOpen || toolMenu.isOpen || wallMenu.isOpen:
		get_tree().paused = true
	else: 
		get_tree().paused = false


func _on_wall_area_mouse_entered():
	get_tree().paused = true


func _on_wall_area_mouse_exited():
	if baseInv.isOpen || toolMenu.isOpen || craftMenu.isOpen:
		get_tree().paused = true
	else: 
		get_tree().paused = false


func _on_tool_area_mouse_entered():
	get_tree().paused = true


func _on_tool_area_mouse_exited():
	if baseInv.isOpen || wallMenu.isOpen || craftMenu.isOpen:
		get_tree().paused = true
	else: 
		get_tree().paused = false

