extends Control

var player_health : float = 100
var max_health : float = 100

var health_bar : TextureProgressBar

func _ready():
	# Assuming you have a TextureProgress node named "health_bar" in your scene
	health_bar = $TextureProgress

	# Set initial health and max value of the health bar
	player_health = max_health
	health_bar.max_value = max_health
	health_bar.value = player_health

func decrease_health(amount: float):
	player_health -= amount
	if player_health < 0:
		player_health = 0

	update_health_bar()

func increase_health(amount: float):
	player_health += amount
	if player_health > max_health:
		player_health = max_health

	update_health_bar()

func update_health_bar():
	health_bar.value = player_health
