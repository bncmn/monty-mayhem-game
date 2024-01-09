extends CharacterBody2D

var moveSpeed = 150
var playerChase = false
var player = null

func _physics_process(delta):
	if playerChase:
		velocity = global_position.direction_to(player.position) * moveSpeed
		if global_position.distance_to(player.position) > 10:
			move_and_slide()

func _on_detection_area_body_entered(body):
	player = body
	playerChase = true

func _on_detection_area_body_exited(body):
	player = null
	playerChase = false

func enemy():
	pass
