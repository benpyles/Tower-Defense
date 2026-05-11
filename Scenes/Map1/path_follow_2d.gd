extends PathFollow2D

@export var speed: float = 150.0

func _process(delta: float) -> void:
	# Move the enemy forward
	progress += speed * delta
	
	# Check if the enemy has reached 100% of the path
	if progress_ratio >= 1.0:
		# Delete the enemy from the game to free up memory
		queue_free()
