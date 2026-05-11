extends Area2D

# --- PRELOADS ---
# Make sure this path is exactly where your Bullet scene is saved!
var bullet_scene: PackedScene = preload("res://Towers/Tank/Bullet.tscn")

# --- VARIABLES ---
@export var damage: int = 5
var targets: Array = []

# --- BUILT-IN FUNCTIONS ---

func _ready() -> void:
	# Safety checks to connect signals only if they aren't already connected
	if not area_entered.is_connected(_on_area_entered):
		area_entered.connect(_on_area_entered)
	
	if not area_exited.is_connected(_on_area_exited):
		area_exited.connect(_on_area_exited)
	
	# Timer setup - Make sure the node is named exactly "ShootTimer"
	var timer = get_node("ShootTimer")
	if not timer.timeout.is_connected(_on_shoot_timer_timeout):
		timer.timeout.connect(_on_shoot_timer_timeout)

func _process(_delta: float) -> void:
	# Aim at the first enemy in our list
	if targets.size() > 0:
		var current_target = targets[0]
		
		if is_instance_valid(current_target):
			look_at(current_target.global_position)
		else:
			# Cleanup if target was destroyed by another tower
			targets.remove_at(0)

# --- SIGNAL & COMBAT FUNCTIONS ---

func _on_shoot_timer_timeout() -> void:
	if targets.size() > 0:
		var current_target = targets[0]
		if is_instance_valid(current_target):
			shoot(current_target)

func shoot(target_node: Node2D) -> void:
	var b = bullet_scene.instantiate()
	b.target = target_node
	b.damage = damage
	b.global_position = global_position 
	
	# Add bullet to the root scene so it doesn't rotate with the tank
	get_tree().current_scene.add_child(b)

func _on_area_entered(area: Area2D) -> void:
	# We look at the parent because the 'area' is usually just the Hitbox
	var enemy = area.get_parent()
	if enemy.has_method("take_damage"):
		targets.append(enemy)

func _on_area_exited(area: Area2D) -> void:
	var enemy = area.get_parent()
	if enemy in targets:
		targets.erase(enemy)
