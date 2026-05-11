extends Label

func _process(_delta: float) -> void:
	text = "Lives: " + str(GameManager.lives)
