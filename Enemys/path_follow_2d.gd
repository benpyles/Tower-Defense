extends PathFollow2D

# --- VARIABLES ---
@export var speed: float = 150.0
@export var health: int = 10

# We use get_node_or_null so the game doesn't crash if you haven't added the bar yet
@onready var health_bar = get_node_or_null("ProgressBar")

# --- BUILT-IN FUNCTIONS ---

func _ready() -> void:
	# Initialize the health bar values
	if health_bar:
		health_bar.max_value = health
		health_bar.value = health

func _process(delta: float) -> void:
	# 1. Move the enemy forward
	progress += speed * delta
	
	# 2. FIXED ROTATION: This tells the bar to stay at 0 degrees 
	# regardless of how much the enemy spins or turns.
	if is_instance_valid(health_bar):
		health_bar.rotation = -rotation 
	
	# 3. Check if reached the end
	if progress_ratio >= 1.0:
		GameManager.lives -= 1
		queue_free()

# --- CUSTOM FUNCTIONS ---

func take_damage(amount: int) -> void:
	# Subtract health and update the visual bar
	health -= amount
	
	if is_instance_valid(health_bar):
		health_bar.value = health
	
	# Check for death
	if health <= 0:
		GameManager.add_gold(15) # Reward the player
		queue_free() # Remove enemy from game
