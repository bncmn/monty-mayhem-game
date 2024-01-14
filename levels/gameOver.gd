extends Control

#@onready var gameOverTheme = $gameOverTheme

# func _on_ready():
	# gameOverTheme.play()

func _on_restart_button_pressed():
	get_tree().reload_current_scene()

func _on_no_exit_button_pressed():
	
	get_tree().change_scene_to_file("res://levels/StartMenu.tscn")
