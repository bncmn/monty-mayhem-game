extends CanvasLayer


@onready var inventory = $BaseInvUI


var counter = 0 #Counter for number of bodies in Area2D
var mouse = 0 #Mouse status


func _ready(): 
	inventory.close()


func _on_base_area_body_entered(body):
	counter += 1


func _on_base_area_body_exited(body):
	counter -= 1


func _on_base_mouse_entered():
	mouse = 1


func _on_base_mouse_exited():
	mouse = 0


func _input(event):
	if counter > 1 && mouse == 1:
		if event.is_action_pressed("mouseLeft"):
			inventory.open()


func _on_base_inv_exit_pressed():
	inventory.close()
