extends CharacterBody2D

var speed = 37.5
var playerChase = false
var player = null

func _physics_process(delta):
	if playerChase:
		position += (player.position - position) / speed

func _on_detection_area_body_entered(body):
	player = body
	playerChase = true


func _on_detection_area_body_exited(body):
	player = null
	playerChase = false
