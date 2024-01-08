extends CharacterBody2D

@export var moveSpeed : float = 300
@onready var animations = $AnimationPlayer
var targetLocation = global_position

func _input(event):
	if event.is_action_pressed("mouseLeft"):
		targetLocation = get_global_mouse_position()

func _physics_process(delta):
	velocity = global_position.direction_to(targetLocation) * moveSpeed
	if global_position.distance_to(targetLocation) > 10:
		# move_and_collide needed some sort of vector in the first argument.
		move_and_slide()
