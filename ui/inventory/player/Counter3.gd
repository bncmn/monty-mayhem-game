extends Label

@onready var ironItem = $"../Item3"

var iron = "res://assets/placeholders/metal_placeholder.png"
var ironEmpty = "res://assets/inventory/iron_drop_empty.png"

func _process(delta):
	if PlayerInventory.resources.has("iron") && PlayerInventory.resources["iron"] != 0:
		text = str(PlayerInventory.resources["iron"])
		ironItem.texture = load(iron)
		ironItem.expand_mode = 1
		ironItem.size = Vector2(80, 80)
	
	elif PlayerInventory.resources.has("iron") && PlayerInventory.resources["iron"] == 0:
		text = ""
		ironItem.texture = load(ironEmpty)
		ironItem.expand_mode = 1
		ironItem.size = Vector2(80, 80)
