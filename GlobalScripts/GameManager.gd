extends Node

# --- SIGNALS ---
# These shout out to the rest of the game whenever a value changes
signal gold_changed(new_amount: int)
signal lives_changed(new_amount: int)

# This variable stays alive even if the map changes!
var gold: int = 100
var tank_price: int = 50
var lives: int = 20

func add_gold(amount: int):
	gold += amount
	gold_changed.emit(gold) # Trigger the signal!
	print("Gold added! Current gold: ", gold)

func spend_gold(amount: int) -> bool:
	if gold >= amount:
		gold -= amount
		gold_changed.emit(gold) # Trigger the signal!
		print("Gold spent! Current gold: ", gold)
		return true # Purchase successful
	else:
		print("Not enough gold!")
		return false # Purchase failed
