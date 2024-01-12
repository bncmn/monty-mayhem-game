extends Panel

@onready var pickaxeText = $Item2

var pickaxe = "res://assets/placeholders/Pickaxe_placeholder.png"
var pickaxePress = false

func _on_axe_pressed():
	pickaxePress = false

func _on_pickaxe_pressed():
	pickaxePress = true

func _on_sword_pressed():
	pickaxePress = false

func _on_craft_button_pressed():
	if pickaxePress == true:
		if BaseInventory.resources.has("wood") && BaseInventory.resources["wood"] >= 1 && \
		BaseInventory.resources.has("iron") && BaseInventory.resources["iron"] >= 1:
			BaseInventory.removeResource("wood")
			BaseInventory.removeResource("iron")
			
			pickaxeText.texture = load(pickaxe)
			pickaxeText.expand_mode = 1
			pickaxeText.size = Vector2(80, 80)
