extends CharacterBody2D

@export var moveSpeed : float = 500

enum {
	SURROUND,
	ATTACK,
	HIT
}

var state = SURROUND;

func move(target, delta):
	var direction = (target - global_position).normalized() 
	var desired_velocity =  direction * moveSpeed
	var steering = (desired_velocity - velocity) * delta * 2.5
	velocity += steering
	move_and_slide()

func _physics_process(delta):
	match state:
		SURROUND:
			move(get_circle_position(randomnum), delta)
		ATTACK:
			move(player.global_position, delta)
		HIT:
			move(player.global_position, delta)
			print("HIT")
			#Slash ANIM
