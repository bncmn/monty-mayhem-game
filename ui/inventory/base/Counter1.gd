extends Label

@onready var item = $"../Item1"

var wood = "res://assets/placeholders/wood_placeholder.png"
var woodEmpty = "res://assets/inventory/wood_drop_empty.png"

func _process(delta):
	if BaseInventory.resources.has("wood") && BaseInventory.resources["wood"] > 0:
		text = str(BaseInventory.resources["wood"])
		item.texture = load(wood)
		item.expand_mode = 1
		item.size = Vector2(80, 80)
		
	elif !BaseInventory.resources.has("wood") || \
	(BaseInventory.resources.has("wood") && BaseInventory.resources["wood"] == 0):
		text = ""
		item.texture = load(woodEmpty)
		item.expand_mode = 1
		item.size = Vector2(80, 80)
