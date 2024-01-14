extends CharacterBody2D

var enemyInAttackRange = false
var enemyAttackCooldown = false
var health = 100
var playerIsAlive = true
var pos : Vector2;
var old_pos : Vector2;
var moving = false

@export var moveSpeed : float = 300
@onready var sprite_2d = $Sprite2D
@onready var animated_sprite = $AnimatedSprite2D
@onready var hurt = $hurt
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
	
	if pos != old_pos:
		moving = true;
	else:
		moving = false;
	#create old pos from pos
	old_pos = pos;
	
	if moving == false:
		animated_sprite.play("idle")
	else:
		animated_sprite.play("walk")
		
	enemyAttack()
	velocity = global_position.direction_to(targetLocation) * moveSpeed
	if global_position.distance_to(targetLocation) > 10 and !Global.mouseOverEnemy:
		move_and_slide()
	
	if health <= 0:
		playerIsAlive = false # add "Game Over" here!
		health = 0
		print("DEBUG: Player is dead!")
		$"../PlayerUI/GameOver".visible = true
		self.queue_free()
		animated_sprite.play("death")

func player():
	pass

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemyInAttackRange = true
		animated_sprite.play("attack")

func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemyInAttackRange = false

func enemyAttack():
	if enemyInAttackRange and !enemyAttackCooldown:
		health -= 5
		enemyAttackCooldown = true
		hurt.play()
		update_health_bar()
		$AnimatedSprite2D.modulate = Color.INDIAN_RED
		await get_tree().create_timer(0.2).timeout
		$AnimatedSprite2D.modulate = Color.WHITE
		$attackCooldown.start()
		animated_sprite.play("hurt")
		print("DEBUG: Player took damage! ", health)

func _on_attack_cooldown_timeout():
	enemyAttackCooldown = false
