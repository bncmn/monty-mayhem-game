extends CharacterBody2D

var enemyInAttackRange = false
var enemyAttackCooldown = false
var health = 100
var playerIsAlive = true

@export var moveSpeed : float = 300
@onready var animations = $AnimationPlayer
var targetLocation = global_position

func update_health_bar():
	print("New bar value is:", $"../PlayerUI/HealthBar".value)
	print("Actual Health his:", health)
	$"../PlayerUI/HealthBar".value = health

func _input(event):
	if event.is_action_pressed("mouseLeft") and !Global.mouseOverResource:
		targetLocation = get_global_mouse_position()

func _physics_process(delta):
	enemyAttack()
	velocity = global_position.direction_to(targetLocation) * moveSpeed
	if global_position.distance_to(targetLocation) > 10 and !Global.mouseOverEnemy:
		move_and_slide()
	
	if health <= 0:
		playerIsAlive = false # add "Game Over" here!
		health = 0
		print("DEBUG: Player is dead!")
		self.queue_free()

func player():
	pass

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemyInAttackRange = true

func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemyInAttackRange = false

func enemyAttack():
	if enemyInAttackRange and !enemyAttackCooldown:
		health -= 5
		enemyAttackCooldown = true
		update_health_bar()
		$Sprite2D.modulate = Color.INDIAN_RED
		await get_tree().create_timer(0.2).timeout
		$Sprite2D.modulate = Color.WHITE
		$attackCooldown.start()
		print("DEBUG: Player took damage! ", health)

func _on_attack_cooldown_timeout():
	enemyAttackCooldown = false
