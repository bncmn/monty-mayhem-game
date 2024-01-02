extends CharacterBody2D

@export var moveSpeed : float = 100

func _physics_process(delta):
	# Read movement
	var inputDirection = Vector2(
		Input.get_action_strength("moveRight") - Input.get_action_strength("moveLeft"),
		Input.get_action_strength("moveDown") - Input.get_action_strength("moveUp")
	)
	print(inputDirection) # DEBUG
	
	# Update velocity
	velocity = inputDirection * moveSpeed
	
	# Move character
	move_and_slide()
