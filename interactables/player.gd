extends CharacterBody2D

var enemyInAttackRange = false
var enemyTypeInRange = null
var enemyAttackCooldown = false
var health = 100
var playerIsAlive = true
var pos : Vector2;
var old_pos : Vector2;
var moving = false

@export var moveSpeed : float = 300
@onready var animated_sprite = $AnimatedSprite2D
var targetLocation = global_position

func update_health_bar():
	$"../PlayerUI/HealthBar".value = health

func _input(event):
	if event.is_action_pressed("mouseLeft") and !Global.mouseOverResource and !$"../BuildMap".isOpen:
		targetLocation = get_global_mouse_position()

func _physics_process(delta):
	#print("The current status of velocity is:", @GlobalScope.is_zero_approx())
	pos = global_position
	print("Global position is: ", pos)
	
	pos = global_position
	if pos != old_pos:
		moving = true;
	else:
		moving = false;
	#create old pos from pos
	old_pos = pos;
	
	if moving == false:
		old_pos = pos;
	
	if moving:
		print("old vs new pos: ", old_pos, pos)
		print("Pos results in", moving)
		animated_sprite.play("walk")
	elif not moving:
		animated_sprite.stop()
	elif not animated_sprite.is_playing():
		animated_sprite.play("idle")
	else:
		animated_sprite.play("walk")
		
	enemyAttack()
	velocity = global_position.direction_to(targetLocation) * moveSpeed
	
	if global_position.distance_to(targetLocation) > 10 and !Global.mouseOverEnemy:
		move_and_slide()
	
	if health <= 0:
		playerIsAlive = false
		get_tree().paused = true # add "Game Over" here!
		health = 0
		print("DEBUG: Player is dead!")
		animated_sprite.stop()
		animated_sprite.play("death")
		animated_sprite.pause()
		await get_tree().create_timer(1).timeout
		self.queue_free()
		$"../PlayerUI/GameOver".visible = true

func player():
	pass

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemyInAttackRange = true
		if body.has_method("egg"):
			enemyTypeInRange = "egg"
		if body.has_method("larva"):
			enemyTypeInRange = "larva"
		if body.has_method("beetle"):
			enemyTypeInRange = "beetle"
		animated_sprite.play("attack")

func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemyInAttackRange = false
		enemyTypeInRange = false

func enemyAttack():
	var damage
	if enemyInAttackRange and !enemyAttackCooldown and playerIsAlive:
		if enemyTypeInRange == "egg":
			damage = 1
		if enemyTypeInRange == "larva":
			damage = 5
		if enemyTypeInRange == "beetle":
			damage = 10
		health -= damage
		animated_sprite.stop()
		animated_sprite.play("hurt")
		enemyAttackCooldown = true
		update_health_bar()
		$AnimatedSprite2D.modulate = Color.INDIAN_RED
		await get_tree().create_timer(0.2).timeout
		$AnimatedSprite2D.modulate = Color.WHITE
		$attackCooldown.start()

		print("DEBUG: Player took damage! ", health)

func _on_attack_cooldown_timeout():
	enemyAttackCooldown = false
