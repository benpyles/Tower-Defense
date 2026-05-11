extends Node

# This variable keeps track of whatever map or menu is currently loaded
var current_scene: Node = null

func _ready() -> void:
	# Let's load your first map right when the game starts!
	# Make sure this path matches the exact name of your map scene.
	load_scene("res://Scenes/map_1.tscn")

func load_scene(scene_path: String) -> void:
	# Step 1: Clean up the old scene if one is already loaded
	if current_scene != null:
		current_scene.queue_free()

	# Step 2: Load the new scene from your project files
	var packed_scene: PackedScene = load(scene_path)
	
	if packed_scene:
		# Step 3: Create a physical instance of that loaded scene
		current_scene = packed_scene.instantiate()
		
		# Step 4: Add it to the Scene Handler so it appears in the game
		add_child(current_scene)
	else:
		print("Error: Could not load scene at path: ", scene_path)
