# Idle.gd
extends State

# Upon entering the state, we set the Player node's velocity to zero.
func enter(_msg := {}) -> void:
	# Disable collisions for owner
	owner.set_collision_layer_bit(0, false)

	# We must declare all the properties we access through `owner` in the `Player.gd` script.
	owner.scale = Vector2.ZERO
	owner.rotation_degrees = 0
	# Add a tween to smoothly scale the player to its normal size.
	var tween = Tween.new()
	owner.add_child(tween)  # Add the Tween to the scene tree
	var normal_size = Vector2(1, 1)  # Replace with your normal size if different
	var duration = 2.0  # Duration of the scaling animation in seconds
	tween.interpolate_property(owner, "scale", Vector2.ZERO, normal_size, duration, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.interpolate_property(owner, "rotation_degrees", owner.rotation_degrees, 180, duration, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.connect("tween_completed", self, "_on_tween_completed")
	tween.start()  # Start the Tween

func _on_tween_completed(object: Object, key: NodePath) -> void:
	state_machine.transition_to("RoamWithCollisions")

func update(delta: float) -> void:
	pass

func exit() -> void:
	# Enable collisions for owner
	owner.set_collision_layer_bit(0, true)
