extends Area2D

@export var speed: float = 600.0
var damage: float = 7.5
var target: Node2D = null

func _ready() -> void:
	# The bullet needs to listen for when it hits an enemy's hitbox
	area_entered.connect(_on_area_entered)

func _process(delta: float) -> void:
	# 1. If the target died or reached the end before the bullet hit, delete the bullet
	if not is_instance_valid(target):
		queue_free()
		return
	
	# 2. Calculate the direction to the target
	var direction = (target.global_position - global_position).normalized()
	
	# 3. Move the bullet in that direction
	global_position += direction * speed * delta
	
	# 4. ROTATION: This makes the bullet's "Forward" face the target's position
	look_at(target.global_position)

func _on_area_entered(area: Area2D) -> void:
	# Get the parent of the hitbox (the enemy)
	var enemy = area.get_parent()
	
	# Only deal damage if this specific enemy is our intended target
	if enemy == target:
		if enemy.has_method("take_damage"):
			enemy.take_damage(damage)
		
		# Destroy the bullet on impact
		queue_free()
