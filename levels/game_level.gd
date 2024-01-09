extends Node2D


func _on_base_inv_ui_closed():
	get_tree().paused = false


func _on_base_inv_ui_opened():
	get_tree().paused = true


func _on_player_inv_area_mouse_entered():
	get_tree().paused = true


func _on_player_inv_area_mouse_exited():
	if $BaseUI/BaseInvUI.isOpen:
		get_tree().paused = true
	else: 
		get_tree().paused = false
