extends KinematicBody2D

signal ship_submerged

export var max_speed = 100

onready var SpaceshipStateMachine = $SpaceshipStateMachine

func mission_completed():
	SpaceshipStateMachine.transition_to("Submerge")

func emit_ship_submerged():
	emit_signal("ship_submerged")
