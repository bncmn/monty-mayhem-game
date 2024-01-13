extends Node2D

@onready var baseInv = $BaseUI/BaseInvUI
@onready var craftMenu = $PlayerUI/CraftUI
@onready var baseNode = get_node("BaseArea")
@onready var canvas_modulate = $CanvasModulate
@onready var buildMap = $BuildMap

var randX
var randY
var enemies = []

var woodPress = false
var stonePress = false
var ironPress = false

func _ready():
	generateResources(1200)
	$dayPhaseTimer.start()
	
	buildMap.close()
	Global.tilemap = buildMap
	set_process(false)

func _process(delta):
	var woodWall = preload("res://interactables/woodWall.tscn").instantiate()
	var stoneWall = preload("res://interactables/stoneWall.tscn").instantiate()
	var ironWall = preload("res://interactables/ironWall.tscn").instantiate()
	
	if woodPress == true:
		add_child(woodWall)
	elif stonePress == true:
		add_child(stoneWall)
	elif ironPress == true:
		add_child(ironWall)

func _on_base_inv_ui_closed():
	get_tree().paused = false

func _on_base_inv_ui_opened():
	get_tree().paused = true

func _on_player_inv_area_mouse_entered():
	get_tree().paused = true

func _on_player_inv_area_mouse_exited():
	if baseInv.isOpen:
		get_tree().paused = true
	else: 
		get_tree().paused = false

func _on_craft_area_mouse_entered():
	get_tree().paused = true

func _on_craft_area_mouse_exited():
	if baseInv.isOpen:
		get_tree().paused = true
	else: 
		get_tree().paused = false
		
func _on_build_area_mouse_entered():
	get_tree().paused = true

func _on_build_area_mouse_exited():
	if baseInv.isOpen:
		get_tree().paused = true
	else: 
		get_tree().paused = false

func generateEnemies(amountOfEnemies):
	var maxDistance = 1000
	var prevX = 0
	var prevY = 0
	randomize()
	for i in amountOfEnemies:
		var enemy = preload("res://interactables/enemy.tscn").instantiate()
		
		# Get a random location within the ranges provided.
		randX = randi_range(-2500, 3500)
		randY = randi_range(-850, 1750)
		
		# If the random location is NOT within a distance of the previously spawned node, spawn it...
		if abs(randX - prevX) > maxDistance and abs(randY - prevY) > maxDistance:
			enemy.global_position = Vector2(randX, randY)
			add_child(enemy)
			enemies.append(enemy)
			prevX = randX
			prevY = randY
		# ...otherwise, add one to reroll.
		else:
			amountOfEnemies += 1

func generateResources(amountOfResourceNodes):
	var maxDistance = 1200
	var prevX = 0
	var prevY = 0
	
	randomize()
	for i in amountOfResourceNodes:
		randX = randi_range(-2500, 3500)
		randY = randi_range(-850, 1750)
		
		# If the random location is NOT within a distance of the previously spawned node, spawn it...
		if abs(randX - prevX) > maxDistance and abs(randY - prevY) > maxDistance:
			if i % 2 == 0:
				var tree = preload("res://interactables/tree_node.tscn").instantiate()
				tree.global_position = Vector2(randX, randY)
				add_child(tree)
				prevX = randX
				prevY = randY
			else:
				var rock = preload("res://interactables/rock_node.tscn").instantiate()
				rock.global_position = Vector2(randX, randY)
				add_child(rock)
				prevX = randX
				prevY = randY
		# ...otherwise, add one to reroll.
		else:
			amountOfResourceNodes += 1

func _on_day_phase_timer_timeout():
	generateEnemies(30)
	$nightPhaseTimer.start()

func _on_night_phase_timer_timeout():
	for enemy in enemies:
		remove_child(enemy)
		enemy.queue_free()
	enemies.clear()
	$dayPhaseTimer.start()

func _on_wall_type_1_pressed():
	woodPress = true

func _on_wall_type_2_pressed():
	stonePress = true

func _on_wall_type_3_pressed():
	ironPress = true

func _on_build_button_pressed():
	set_process(true)
	buildMap.open()
