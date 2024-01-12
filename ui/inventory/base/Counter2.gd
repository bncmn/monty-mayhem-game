extends Label

@onready var item = $"../Item2"

var rock = "res://assets/inventory/rock_drop.png"
var rockEmpty = "res://assets/inventory/rock_drop_empty.png"

func _process(delta):
	if BaseInventory.resources.has("rock") && BaseInventory.resources["rock"] > 0:
		text = str(BaseInventory.resources["rock"])
		item.texture = load(rock)
		item.expand_mode = 1
		item.size = Vector2(80, 80)
		
	elif !BaseInventory.resources.has("rock") || \
	(BaseInventory.resources.has("rock") && BaseInventory.resources["rock"] == 0):
		text = ""
		item.texture = load(rockEmpty)
		item.expand_mode = 1
		item.size = Vector2(80, 80)
