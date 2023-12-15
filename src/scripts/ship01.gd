extends KinematicBody2D

var speed = 0
var rotation_speed = 1.0
var acceleration = 50
var deceleration = 50

onready var Camera = $Camera2D

func _ready():
	pass

func _process(delta):
	print(rotation_degrees)
	if Input.is_action_pressed('ui_up'):
		speed += acceleration * delta
	elif Input.is_action_pressed('ui_down'):
		speed -= deceleration * delta
	if Input.is_action_pressed('ui_left'):
		rotation_degrees -= rotation_speed
	elif Input.is_action_pressed('ui_right'):
		rotation_degrees += rotation_speed

	move_and_slide(Vector2.UP.rotated(rotation) * speed)


