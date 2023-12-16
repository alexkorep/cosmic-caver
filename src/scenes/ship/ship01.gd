extends KinematicBody2D

signal ship_submerged
signal ship_clicked_outside_range

export var max_speed := 100.0
export var max_range := 500

onready var SpaceshipStateMachine = $SpaceshipStateMachine

func mission_completed():
	SpaceshipStateMachine.transition_to("Submerge")

func emit_ship_submerged():
	emit_signal("ship_submerged")
	
func emit_clicked_outside_range():
	emit_signal("ship_clicked_outside_range")
	
