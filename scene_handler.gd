extends Node2D

# This variable keeps track of whatever map or menu is currently loaded
var current_scene: Node = null
var tank_scene: PackedScene = preload("res://Towers/Tank/Tank.tscn")

func _ready() -> void:
	load_scene("res://Scenes/Map1/map_1.tscn")
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if GameManager.gold >= GameManager.tank_price:
			# This works now because we are extending Node2D again
			var mouse_pos = get_global_mouse_position()
			spawn_tank(mouse_pos)
		else:
			print("Too poor!")

func spawn_tank(location: Vector2) -> void:
	if current_scene == null:
		return
	
	# Spend gold
	GameManager.spend_gold(GameManager.tank_price)
	
	# Create the tank
	var new_tank = tank_scene.instantiate()
	
	# Add the tank to the map so it moves with the map
	current_scene.add_child(new_tank)
	
	# Set position
	new_tank.global_position = location

func load_scene(scene_path: String) -> void:
	if current_scene != null:
		current_scene.queue_free()

	var packed_scene: PackedScene = load(scene_path)
	
	if packed_scene:
		current_scene = packed_scene.instantiate()
		add_child(current_scene)
	else:
		print("Error: Could not load scene at path: ", scene_path)
