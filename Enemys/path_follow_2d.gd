extends PathFollow2D

# --- VARIABLES ---
@export var speed: float = 150.0
@export var max_health: int = 10

@export var gold_reward: int = 15

# We use @onready to set current_health to max_health right when the enemy spawns
@onready var current_health: int = max_health

# Grab the health bar directly. 
# Make sure your health bar node is named EXACTLY "TextureProgressBar" in the Scene Tree!
@onready var health_bar = $TextureProgressBar

# --- BUILT-IN FUNCTIONS ---

func _ready() -> void:
	# Initialize the health bar values right away
	if is_instance_valid(health_bar):
		health_bar.max_value = max_health
		health_bar.value = current_health

func _process(delta: float) -> void:
	# 1. Move the enemy forward along the path
	progress += speed * delta
	
	
	# 3. Check if it reached the end of the path
	if progress_ratio >= 1.0:
		# Ask the Scene Tree if the GameManager node exists
		if has_node("/root/GameManager"):
			GameManager.lives -= 1
		queue_free() # This deletes the ENTIRE enemy

# --- CUSTOM FUNCTIONS ---

func take_damage(amount: int) -> void:
	# Subtract health
	current_health -= amount
	
	# Update the visual bar directly
	if is_instance_valid(health_bar):
		health_bar.value = current_health
		
	if has_node("/root/GameManager"):
			print("gold added!")
			GameManager.add_gold(gold_reward)
	
	# Check for death
	if current_health <= 0:
		print("health none")
		if Engine.has_singleton("GameManager"):
			print('gold added?')
			GameManager.add_gold(gold_reward) 
		queue_free() # The whole enemy dies
