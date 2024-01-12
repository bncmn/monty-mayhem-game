extends Label

@onready var item = $"../Item1"

var wood = "res://assets/placeholders/wood_placeholder.png"
var woodEmpty = "res://assets/inventory/wood_drop_empty.png"

func _process(delta):
	if PlayerInventory.resources.has("wood") && PlayerInventory.resources["wood"] > 0:
		text = str(PlayerInventory.resources["wood"])
		item.texture = load(wood)
		item.expand_mode = 1
		item.size = Vector2(80, 80)
		
	elif PlayerInventory.resources.has("wood") && PlayerInventory.resources["wood"] == 0:
		text = ""
		item.texture = load(woodEmpty)
		item.expand_mode = 1
		item.size = Vector2(80, 80)
