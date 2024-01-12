extends Panel

@onready var swordText = $Item3

var sword = "res://assets/equipment/SwordDestroyer.png"
var swordPress = false

func _on_axe_pressed():
	swordPress = false

func _on_pickaxe_pressed():
	swordPress = false

func _on_sword_pressed():
	swordPress = true

func _on_craft_button_pressed():
	if swordPress == true:
		if BaseInventory.resources.has("wood") && BaseInventory.resources["wood"] >= 1 && \
		BaseInventory.resources.has("iron") && BaseInventory.resources["iron"] >= 1:
			BaseInventory.removeResource("wood")
			BaseInventory.removeResource("iron")
			
			swordText.texture = load(sword)
			swordText.expand_mode = 1
			swordText.size = Vector2(80, 80)
