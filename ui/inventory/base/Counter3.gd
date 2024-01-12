extends Label

@onready var item = $"../Item3"

var iron = "res://assets/inventory/iron_drop.png"
var ironEmpty = "res://assets/inventory/iron_drop_empty.png"

func _process(delta):
	if BaseInventory.resources.has("iron") && BaseInventory.resources["iron"] > 0:
		text = str(BaseInventory.resources["iron"])
		item.texture = load(iron)
		item.expand_mode = 1
		item.size = Vector2(80, 80)
		
	elif !BaseInventory.resources.has("iron") || \
	(BaseInventory.resources.has("iron") && BaseInventory.resources["iron"] == 0):
		text = ""
		item.texture = load(ironEmpty)
		item.expand_mode = 1
		item.size = Vector2(80, 80)
