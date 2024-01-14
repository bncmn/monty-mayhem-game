extends StaticBody2D

var enemyInAttackRange = false
var enemyTypeInRange = null
var enemyAttackCooldown = false
var wallHealth

func _physics_process(delta):
	enemyHitWall()
	
	if wallHealth <= 0:
		print("DEBUG: Wall is down!")
		self.queue_free()

func wall():
	pass

func _on_wall_hitbox_body_entered(body):
	if body.has_method("enemy"):
		if body.has_method("egg"):
			enemyTypeInRange = "egg"
		if body.has_method("larva"):
			enemyTypeInRange = "larva"
		if body.has_method("beetle"):
			enemyTypeInRange = "beetle"
		enemyInAttackRange = true

func _on_wall_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemyInAttackRange = false
		enemyTypeInRange = null

func enemyHitWall():
	var damage
	if enemyInAttackRange and !enemyAttackCooldown:
		if enemyTypeInRange == "egg":
			damage = 5
		if enemyTypeInRange == "larva":
			damage = 10
		if enemyTypeInRange == "beetle":
			damage = 15
		wallHealth -= damage
		enemyAttackCooldown = true
		$attackCooldown.start()
		print("DEBUG: Wall took damage! ", wallHealth)

func _on_attack_cooldown_timeout():
	enemyAttackCooldown = false
