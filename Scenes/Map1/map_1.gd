extends Node2D

# Load the enemy blueprint into memory before the game starts
var enemy_scene: PackedScene = preload("res://Scenes/Map1/enemy.tscn")

# This function runs every time the SpawnTimer reaches 0
func _on_spawn_timer_timeout() -> void:
	
	# 1. Build a new enemy from the blueprint
	var new_enemy = enemy_scene.instantiate()
	
	# 2. Find the Path2D node and add the new enemy as a child
	# (Because the enemy is a PathFollow2D, it will automatically snap to the start of the path!)
	$Path2D.add_child(new_enemy)

func _on_timer_timeout() -> void:
	pass # Replace with function body.
