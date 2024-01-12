extends Label

@onready var rockItem = $"../Item2"

var rock = "res://assets/placeholders/rock_material_placeholder.png"
var rockEmpty = "res://assets/inventory/rock_drop_empty.png"

func _process(delta):
	if PlayerInventory.resources.has("rock") && PlayerInventory.resources["rock"] != 0:
		text = str(PlayerInventory.resources["rock"])
		rockItem.texture = load(rock)
		rockItem.expand_mode = 1
		rockItem.size = Vector2(80, 80)
		
	elif !PlayerInventory.resources.has("rock") || \
	(PlayerInventory.resources.has("rock") && PlayerInventory.resources["rock"] == 0):
		text = ""
		rockItem.texture = load(rockEmpty)
		rockItem.expand_mode = 1
		rockItem.size = Vector2(80, 80)
