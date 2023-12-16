extends KinematicBody2D

export var max_speed = 100

var speed = 0.0
var rotation_speed = 1.0
var acceleration = 50.0
var deceleration = 50.0

onready var Camera = $Camera2D

func _ready():
	pass

func _process(delta):
	if Input.is_action_pressed('ui_up'):
		speed += acceleration * delta
		if speed > max_speed:
			speed = max_speed
	elif Input.is_action_pressed('ui_down'):
		speed -= deceleration * delta
		if speed < -max_speed:
			speed = -max_speed
	if Input.is_action_pressed('ui_left'):
		rotation_degrees -= rotation_speed
	elif Input.is_action_pressed('ui_right'):
		rotation_degrees += rotation_speed

	var linear_velocity = Vector2.UP.rotated(rotation) * speed
	move_and_slide(linear_velocity)


