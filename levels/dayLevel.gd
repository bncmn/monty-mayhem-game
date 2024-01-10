extends Node2D

@onready var baseInv = $BaseUI/BaseInvUI
@onready var craftMenu = $PlayerUI/CraftUI
@onready var toolMenu = $CraftMenuUI/ToolUI
@onready var wallMenu = $CraftMenuUI/WallUI

var randX
var randY

func _ready():
	generateEnemies(10)
	generateTrees(20)
	generateRocks(20)

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
	if baseInv.isOpen || toolMenu.isOpen || wallMenu.isOpen:
		get_tree().paused = true
	else: 
		get_tree().paused = false


func _on_wall_area_mouse_entered():
	get_tree().paused = true


func _on_wall_area_mouse_exited():
	if baseInv.isOpen || toolMenu.isOpen || craftMenu.isOpen:
		get_tree().paused = true
	else: 
		get_tree().paused = false


func _on_tool_area_mouse_entered():
	get_tree().paused = true


func _on_tool_area_mouse_exited():
	if baseInv.isOpen || wallMenu.isOpen || craftMenu.isOpen:
		get_tree().paused = true
	else: 
		get_tree().paused = false

func generateEnemies(amountOfEnemies):
	var maxDistance = 150
	var prevX = 0
	var prevY = 0
	randomize()
	for i in amountOfEnemies:
		var enemy = preload("res://interactables/enemy.tscn").instantiate()
		
		# Get a random location within the ranges provided.
		randX = randi_range(-500, 2500)
		randY = randi_range(-500, 1500)
		
		# If the random location is NOT within a distance of the previously spawned node, spawn it...
		if abs(randX - prevX) > maxDistance and abs(randY - prevY) > maxDistance:
			enemy.global_position = Vector2(randX, randY)
			add_child(enemy)
			prevX = randX
			prevY = randY
		# ...otherwise, add one to reroll.
		else:
			amountOfEnemies += 1

func generateTrees(amountOfTrees):
	var maxDistance = 300
	var prevX = 0
	var prevY = 0
	
	randomize()
	for i in amountOfTrees:
		var tree = preload("res://interactables/tree_node.tscn").instantiate()
		
		randX = randi_range(-500, 2500)
		randY = randi_range(-500, 1500)
		
		# If the random location is NOT within a distance of the previously spawned node, spawn it...
		if abs(randX - prevX) > maxDistance and abs(randY - prevY) > maxDistance:
			tree.global_position = Vector2(randX, randY)
			add_child(tree)
			prevX = randX
			prevY = randY
		# ...otherwise, add one to reroll.
		else:
			amountOfTrees += 1

func generateRocks(amountOfRocks):
	var maxDistance = 300
	var prevX = 0
	var prevY = 0
	
	randomize()
	for i in amountOfRocks:
		var rock = preload("res://interactables/rock_node.tscn").instantiate()
		
		randX = randi_range(-500, 2500)
		randY = randi_range(-500, 1500)
		
		# If the random location is NOT within a distance of the previously spawned node, spawn it...
		if abs(randX - prevX) > maxDistance and abs(randY - prevY) > maxDistance:
			rock.global_position = Vector2(randX, randY)
			add_child(rock)
			prevX = randX
			prevY = randY
		# ...otherwise, add one to reroll.
		else:
			amountOfRocks += 1
