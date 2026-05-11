extends Area2D

@export var damage: float = 5
var targets: Array = [] # A list to keep track of enemies in range

func _on_shoot_timer_timeout() -> void:
	# If there is at least one enemy in our list...
	if targets.size() > 0:
		var current_target = targets[0]
		
		# Make sure the enemy still exists (wasn't killed by something else)
		if is_instance_valid(current_target):
			current_target.take_damage(damage)
			print("Firing at enemy! Health remaining unknown.")
		else:
			# If the enemy is gone, remove it from our list
			targets.remove_at(0)

func _on_area_entered(area: Area2D) -> void:
	var enemy = area.get_parent()
	if enemy.has_method("take_damage"):
		# Add this enemy to our target list
		targets.append(enemy)

func _on_area_exited(area: Area2D) -> void:
	var enemy = area.get_parent()
	# If an enemy walks out of our circle, remove them from the list
	if enemy in targets:
		targets.erase(enemy)
