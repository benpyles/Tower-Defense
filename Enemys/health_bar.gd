extends TextureProgressBar

@export var enemy: Sprite2D

# You don't necessarily need a 'player' reference here if the 
# Enemy script is already setting 'value' directly.

func _ready():
	enemy.healthChanged.connect(update)
	#	update()

func update(current_health, max_health):
	value = enemy.currentHealth * 100 / enemy.maxHealth
