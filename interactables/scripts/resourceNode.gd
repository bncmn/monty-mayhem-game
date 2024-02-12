extends StaticBody2D

# Randomize the number of clicks it takes to "harvest" the resource.
var clicksToDie = RandomNumberGenerator.new().randi_range(2,5)

# Track the number of times the node has been clicked.
var currentClicks = 0;

var isCollectable = false

func _ready():
	set_process_input(true)

func _on_collection_area_body_entered(body):
	if body.has_method("player"):
		isCollectable = true

func _on_collection_area_body_exited(body):
	if body.has_method("player"):
		isCollectable = false

func deleteResource():
	Global.mouseOverResource = false
	queue_free()

func _on_mouse_entered():
	if isCollectable:
		Global.mouseOverResource = true

func _on_mouse_exited():
	if isCollectable:
		Global.mouseOverResource = false
