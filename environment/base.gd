extends Node2D


var counter = 0 #Counter for number of bodies in Area2D
var mouse = 0 #Mouse status


func _ready(): 
	$BaseInv.visible = false #Base inventory not visible on ready


func _on_area_2d_body_entered(body):
	counter += 1 #Counter increases as each body enters area
	print("Body entered area")


func _on_area_2d_body_exited(body):
	counter -= 1 #Counter decreases as each body exits area
	print("Body exited area")


func _on_area_2d_mouse_entered():
	mouse = 1 #Mouse status is 1 when cursor enters area


func _on_area_2d_mouse_exited():
	mouse = 0 #Mouse status is 0 when cursor exits area


func _input(event):
	#If inventory not visible while player and mouse enter area, mouse click allows visibility
	if $BaseInv.is_visible() == false && counter >= 2 && mouse == 1: 
		if event.is_action_pressed("mouseLeft"):
			$BaseInv.visible = true
			print("Show base inventory")
	
	#Else if inventory is visible while player and mouse enter area, mouse click does not allow visibility
	elif $BaseInv.is_visible() == true && counter >= 2 && mouse == 1:
		if event.is_action_pressed("mouseLeft"):
			$BaseInv.visible = false
			print("Hide base inventory")

	#If player exits area, inventory closes
	if counter < 2:
		$BaseInv.visible = false
