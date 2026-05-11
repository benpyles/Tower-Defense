extends PathFollow2D

# --- VARIABLES ---
@export var speed: float = 150.0
@export var health: int = 10


# --- BUILT-IN FUNCTIONS ---
func _process(delta: float) -> void:
	# 1. Move the enemy forward along the path
	progress += speed * delta
	
	# 2. Check if the enemy has reached the end of the track (100%)
	if progress_ratio >= 1.0:
		# Delete the enemy from the game when it finishes the path
		queue_free()


# --- CUSTOM FUNCTIONS ---
func take_damage(amount: int) -> void:
	# Subtract the damage from the enemy's current health
	health -= amount
	
	# Check if the enemy is dead
	if health <= 0:
		# Delete the enemy from the game
		queue_free()
