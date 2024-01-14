extends StaticBody2D

var enemyInAttackRange = false
var enemyAttackCooldown = false
var wallHealth = 20

func _physics_process(delta):
	enemyHitWall()
	
	if wallHealth <= 0:
		print("DEBUG: Wall is down!")
		self.queue_free()

func wall():
	pass

func _on_wall_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemyInAttackRange = true

func _on_wall_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemyInAttackRange = false

func enemyHitWall():
	if enemyInAttackRange and !enemyAttackCooldown:
		wallHealth -= 5
		enemyAttackCooldown = true
		$attackCooldown.start()
		print("DEBUG: Wall took damage! ", wallHealth)

func _on_attack_cooldown_timeout():
	enemyAttackCooldown = false
