extends CharacterBody2D

var moveSpeed = 100#230
var playerChase = false
var goToWall = false
var player = null
var wall = null
var health = 100
var playerInAttackRange = true
var playerAttackCooldown = false
var pos : Vector2;
var old_pos : Vector2;
var moving = false

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	pos = global_position
	if pos != old_pos:
		moving = true;
	else:
		moving = false;
	old_pos = pos;
	
	if moving:
		print("old vs new pos: ", old_pos, pos)
		print("Pos results in", moving)
		animated_sprite.play("walk")
	elif not moving:
		animated_sprite.stop()
	elif not animated_sprite.is_playing():
		animated_sprite.play("idle")
		
	if playerChase:
		velocity = global_position.direction_to(player.position) * moveSpeed
		if global_position.distance_to(player.position) > 60:
			move_and_slide()
	
	elif goToWall:
		velocity = global_position.direction_to(wall.position) * moveSpeed
		if global_position.distance_to(wall.position) > 60:
			move_and_slide()
	
	if health <= 0:
		print("DEBUG: Enemy is dead!")
		Global.mouseOverEnemy = false
		self.queue_free()

func _on_detection_area_body_entered(body):
	if body.has_method("player"):
		player = body
		playerChase = true
	
	if body.has_method("wall"):
		wall = body
		goToWall = true

func _on_detection_area_body_exited(body):
	if body.has_method("player"):
		player = null
		playerChase = false
	
	if body.has_method("wall"):
		wall = null
		goToWall = false

func _on_enemy_hitbox_body_entered(body):
	if body.has_method("player"):
		playerInAttackRange = true

func _on_enemy_hitbox_body_exited(body):
	if body.has_method("player"):
		playerInAttackRange = false

func playerAttack():
	if playerInAttackRange and !playerAttackCooldown:
		if PlayerInventory.tools.has("sword"):
			health -= 25
			PlayerInventory.decreaseToolDurability("sword")
			PlayerInventory.printToConsole()
		else:
			health -= 5
		playerAttackCooldown = true
		animated_sprite.stop()
		animated_sprite.play("hurt")
		$AnimatedSprite2D.modulate = Color.INDIAN_RED
		await get_tree().create_timer(0.2).timeout
		$AnimatedSprite2D.modulate = Color.WHITE
		$attackCooldown.start()
		print("DEBUG: Enemy took damage! ", health)

func _on_attack_cooldown_timeout():
	playerAttackCooldown = false

func _on_enemy_hitbox_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		playerAttack()

func _on_enemy_hitbox_mouse_entered():
	Global.mouseOverEnemy = true

func _on_enemy_hitbox_mouse_exited():
	Global.mouseOverEnemy = false

func larva():
	pass

func enemy():
	pass
