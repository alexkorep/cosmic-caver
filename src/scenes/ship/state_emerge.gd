# Idle.gd
extends State

# Upon entering the state, we set the Player node's velocity to zero.
func enter(_msg := {}) -> void:
	# Disable collisions for owner
	owner.set_collision_layer_value(0, false)

	# We must declare all the properties we access through `owner` in the `Player.gd` script.
	owner.scale = Vector2.ZERO
	owner.rotation_degrees = 0
	var normal_size = Vector2(1, 1)  # Replace with your normal size if different
	var duration = 2.0  # Duration of the scaling animation in seconds

	# Create a Tween for scaling
	var tween_scale = owner.create_tween()
	tween_scale.tween_property(owner, "scale", normal_size, duration).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)

	# Create a Tween for rotation
	var tween_rotation = owner.create_tween()
	tween_rotation.tween_property(owner, "rotation_degrees", 180, duration).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)

	tween_scale.connect("finished", _on_tween_completed)

	# Start the Tweens
	tween_scale.play()
	tween_rotation.play()

func _on_tween_completed() -> void:
	state_machine.transition_to("RoamWithCollisions")

func update(delta: float) -> void:
	pass

func exit() -> void:
	# Enable collisions for owner
	owner.set_collision_layer_value(0, true)
