extends Node2D

@onready var baseInv = $BaseUI/BaseInvUI
@onready var craftMenu = $PlayerUI/CraftUI
@onready var baseNode = get_node("BaseArea")
@onready var canvas_modulate = $CanvasModulate
@onready var buildMap = $BuildMap
@onready var day_music = $AudioDay
@onready var night_music = $AudioNight
@onready var woodMenu = $BuildMenuUI/WoodMenu
@onready var stoneMenu = $BuildMenuUI/StoneMenu
@onready var ironMenu = $BuildMenuUI/IronMenu
@onready var exitBuild = $BuildMenuUI/ExitBuild

var numDaysPassed = 1
var randX
var randY
var enemies = []

var woodPress = false
var stonePress = false
var ironPress = false

func _ready():
	generateResources(1200)
	$dayPhaseTimer.start()
	#day_music.play()
	day_music.play()
	
	buildMap.close()
	exitBuild.close()
	woodMenu.close()
	stoneMenu.close()
	ironMenu.close()
	Global.tilemap = buildMap

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
	var enemy
	var maxDistance = 1000
	var prevX = 0
	var prevY = 0
	randomize()
	for i in amountOfEnemies:
		if numDaysPassed % 2 == 0:
			enemy = preload("res://interactables/larva.tscn").instantiate()
		elif numDaysPassed % 3 == 0:
			enemy = preload("res://interactables/enemy.tscn").instantiate()
		else:
			enemy = preload("res://interactables/egg.tscn").instantiate()
		
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
	day_music.stop()
	night_music.play()

func _on_night_phase_timer_timeout():
	for enemy in enemies:
		remove_child(enemy)
		enemy.queue_free()
	enemies.clear()
	$dayPhaseTimer.start()
	numDaysPassed += 1
	night_music.stop()
	day_music.play()

func _on_wall_type_1_pressed():
	woodMenu.open()
	stoneMenu.close()
	ironMenu.close()

func _on_wall_type_2_pressed():
	stoneMenu.open()
	woodMenu.close()
	ironMenu.close()

func _on_wall_type_3_pressed():
	ironMenu.open()
	woodMenu.close()
	stoneMenu.close()

func _on_build_button_pressed():
	buildMap.open()
	exitBuild.open()

func _on_exit_build_pressed():
	buildMap.close()
	exitBuild.close()
	woodMenu.close()
	stoneMenu.close()
	ironMenu.close()

func _on_wood_1_pressed():
	var woodWall = preload("res://interactables/wood wall/wood_wall.tscn").instantiate()
	add_child(woodWall)


func _on_wood_2_pressed():
	var woodWall = preload("res://interactables/wood wall/wood_wall_2.tscn").instantiate()
	add_child(woodWall)


func _on_wood_3_pressed():
	var woodWall = preload("res://interactables/wood wall/wood_wall_3.tscn").instantiate()
	add_child(woodWall)


func _on_wood_4_pressed():
	var woodWall = preload("res://interactables/wood wall/wood_wall_4.tscn").instantiate()
	add_child(woodWall)


func _on_wood_6_pressed():
	var woodWall = preload("res://interactables/wood wall/wood_wall_6.tscn").instantiate()
	add_child(woodWall)


func _on_wood_7_pressed():
	var woodWall = preload("res://interactables/wood wall/wood_wall_7.tscn").instantiate()
	add_child(woodWall)


func _on_wood_8_pressed():
	var woodWall = preload("res://interactables/wood wall/wood_wall_8.tscn").instantiate()
	add_child(woodWall)


func _on_wood_9_pressed():
	var woodWall = preload("res://interactables/wood wall/wood_wall_9.tscn").instantiate()
	add_child(woodWall)


func _on_stone_1_pressed():
	var stoneWall = preload("res://interactables/stone wall/stone_wall.tscn").instantiate()
	add_child(stoneWall)


func _on_stone_2_pressed():
	var stoneWall = preload("res://interactables/stone wall/stone_wall_2.tscn").instantiate()
	add_child(stoneWall)


func _on_stone_3_pressed():
	var stoneWall = preload("res://interactables/stone wall/stone_wall_3.tscn").instantiate()
	add_child(stoneWall)


func _on_stone_4_pressed():
	var stoneWall = preload("res://interactables/stone wall/stone_wall_4.tscn").instantiate()
	add_child(stoneWall)


func _on_stone_6_pressed():
	var stoneWall = preload("res://interactables/stone wall/stone_wall_6.tscn").instantiate()
	add_child(stoneWall)


func _on_stone_7_pressed():
	var stoneWall = preload("res://interactables/stone wall/stone_wall_7.tscn").instantiate()
	add_child(stoneWall)


func _on_stone_8_pressed():
	var stoneWall = preload("res://interactables/stone wall/stone_wall_8.tscn").instantiate()
	add_child(stoneWall)


func _on_stone_9_pressed():
	var stoneWall = preload("res://interactables/stone wall/stone_wall_9.tscn").instantiate()
	add_child(stoneWall)


func _on_iron_1_pressed():
	var ironWall = preload("res://interactables/iron wall/iron_wall.tscn").instantiate()
	add_child(ironWall)


func _on_iron_2_pressed():
	var ironWall = preload("res://interactables/iron wall/iron_wall_2.tscn").instantiate()
	add_child(ironWall)


func _on_iron_3_pressed():
	var ironWall = preload("res://interactables/iron wall/iron_wall_3.tscn").instantiate()
	add_child(ironWall)


func _on_iron_4_pressed():
	var ironWall = preload("res://interactables/iron wall/iron_wall_4.tscn").instantiate()
	add_child(ironWall)


func _on_iron_6_pressed():
	var ironWall = preload("res://interactables/iron wall/iron_wall_6.tscn").instantiate()
	add_child(ironWall)


func _on_iron_7_pressed():
	var ironWall = preload("res://interactables/iron wall/iron_wall_7.tscn").instantiate()
	add_child(ironWall)


func _on_iron_8_pressed():
	var ironWall = preload("res://interactables/iron wall/iron_wall_8.tscn").instantiate()
	add_child(ironWall)


func _on_iron_9_pressed():
	var ironWall = preload("res://interactables/iron wall/iron_wall_9.tscn").instantiate()
	add_child(ironWall)
