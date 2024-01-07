extends Node2D


func _on_base_inv_ui_closed():
	get_tree().paused = false


func _on_base_inv_ui_opened():
	get_tree().paused = true

