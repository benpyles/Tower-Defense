extends Label

func _process(_delta: float) -> void:
	# Update the text every frame to match the global gold
	text = "Gold: " + str(GameManager.gold)
