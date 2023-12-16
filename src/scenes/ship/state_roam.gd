extends State

var speed = 0.0
var rotation_speed = 1.0
var acceleration = 50.0
var deceleration = 50.0

# Upon entering the state, we set the Player node's velocity to zero.
func enter(_msg := {}) -> void:
	pass

func update(delta: float) -> void:
	if Input.is_action_pressed('ui_up'):
		speed += acceleration * delta
		if speed > owner.max_speed:
			speed = owner.max_speed
	elif Input.is_action_pressed('ui_down'):
		speed -= deceleration * delta
		if speed < -owner.max_speed:
			speed = -owner.max_speed
	if Input.is_action_pressed('ui_left'):
		owner.rotation_degrees -= rotation_speed
	elif Input.is_action_pressed('ui_right'):
		owner.rotation_degrees += rotation_speed

	var linear_velocity = Vector2.UP.rotated(owner.rotation) * speed
	owner.move_and_slide(linear_velocity)
	
	
	
