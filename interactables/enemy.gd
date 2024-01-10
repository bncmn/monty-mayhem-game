extends CharacterBody2D

var moveSpeed = 250
var playerChase = false
var player = null
var health = 100
var playerInAttackRange = true
var playerAttackCooldown = false

func _physics_process(delta):
	if playerChase:
		velocity = global_position.direction_to(player.position) * moveSpeed
		if global_position.distance_to(player.position) > 60:
			move_and_slide()
	
	if health <= 0:
		print("DEBUG: Enemy is dead!")
		Global.mouseOverEnemy = false
		self.queue_free()

func _on_detection_area_body_entered(body):
	player = body
	playerChase = true

func _on_detection_area_body_exited(body):
	player = null
	playerChase = false

func enemy():
	pass

func _on_enemy_hitbox_body_entered(body):
	if body.has_method("player"):
		playerInAttackRange = true

func _on_enemy_hitbox_body_exited(body):
	if body.has_method("player"):
		playerInAttackRange = false

func playerAttack():
	if playerInAttackRange and !playerAttackCooldown:
		health -= 10
		playerAttackCooldown = true
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
