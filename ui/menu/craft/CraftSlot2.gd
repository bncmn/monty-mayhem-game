extends Panel

@onready var pickaxeText = $Item2

var pickaxe = "res://assets/inventory/Pickaxe.png"
var pickaxeBroken = "res://assets/inventory/Pickaxe_grey.png"
var pickaxePress = false

func _process(delta):
	if (PlayerInventory.tools.has("pickaxe") && PlayerInventory.tools["pickaxe"]["durabilityRemaining"] == 0) || \
	!PlayerInventory.tools.has("pickaxe"):
		pickaxeText.texture = load(pickaxeBroken)
		pickaxeText.expand_mode = 1
		pickaxeText.size = Vector2(80, 80)
		PlayerInventory.printToConsole()

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
