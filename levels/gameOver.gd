extends Control

@onready var gameOverScreen = 

func _on_restart_button_pressed():
	get_tree().reload_current_scene()
