extends Panel

@onready var axeText = $Item1

var axe = "res://assets/placeholders/wood axe_placeholder.png"
var axePress = false

func _on_axe_pressed():
	axePress = true

func _on_pickaxe_pressed():
	axePress = false

func _on_sword_pressed():
	axePress = false

func _on_craft_button_pressed():
	if axePress == true:
		if BaseInventory.resources.has("wood") && BaseInventory.resources["wood"] >= 1 && \
		BaseInventory.resources.has("iron") && BaseInventory.resources["iron"] >= 1:
			BaseInventory.removeResource("wood")
			BaseInventory.removeResource("iron")
			
			axeText.texture = load(axe)
			axeText.expand_mode = 1
			axeText.size = Vector2(80, 80)
