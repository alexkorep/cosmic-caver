extends State

var current_tween: Tween = null

var velocity = Vector2.ZERO

var move_end_time = 0
var movement_target: Vector2

# Upon entering the state, we set the Player node's velocity to zero.
func enter(_msg := {}) -> void:
	# If rotation is more than 360, make it less than 360
	owner.rotation = wrap_angle(owner.rotation)

func update(delta: float) -> void:
	if Time.get_ticks_msec() <= move_end_time:
		owner.set_velocity(velocity)
		owner.move_and_slide()
		owner.velocity
	
func handle_input(event: InputEvent) -> void:
	if ((event is InputEventMouseButton and event.pressed) or 
		(event is InputEventScreenTouch and event.pressed)):
		# Convert event.position to world coordinates
		# var world_position = event.position
		# var world_position = owner.get_viewport().get_camera_2d().unproject_position(event.position)
		var world_position = owner.get_global_mouse_position()
		move_to(world_position)
	
func move_to(target: Vector2) -> void:
	stop_all()
	movement_target = target

	current_tween = owner.create_tween()

	# Rotate to face the target
	var direction_to_target = target - owner.position
	var target_angle = direction_to_target.angle() + PI / 2
	var diff = target_angle - owner.rotation
	# If the difference is more than 180, rotate the other way
	if diff > PI:
		target_angle -= 2 * PI
	elif diff < -PI:
		target_angle += 2 * PI
	# Calculate duration based on rotation speed
	var duration = abs((target_angle - owner.rotation) / owner.max_rotation_speed)
	current_tween.tween_property(owner, "rotation", 
		target_angle, duration).set_trans(
			Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
	current_tween.connect("finished", _on_rotation_completed)
	current_tween.play()

func _on_rotation_completed() -> void:
	owner.rotation = wrap_angle(owner.rotation)
	# Start moving to the target
	# Calculate duration based on speed
	var move_duration = owner.position.distance_to(movement_target) / owner.max_speed
	# Get timer end time
	move_end_time = Time.get_ticks_msec() + move_duration * 1000
	# Move to the target
	# Set owner speed towards target
	velocity = (movement_target - owner.position).normalized() * owner.max_speed
	owner.set_velocity(velocity)
	owner.move_and_slide()

func wrap_angle(angle):
	var two_pi = 2 * PI
	return angle - floor(angle / two_pi) * two_pi

func stop_all():
	if current_tween != null:
		current_tween.stop_all()
		current_tween.queue_free()
		current_tween = null

func exit() -> void:
	stop_all()

