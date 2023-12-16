extends Node

var current_level = 0

func get_current_level() -> int:
	return current_level

func next_level():
	# TODO - add some logic to check if the next level exists
	current_level += 1
