extends State

var finished := false

func enter(_msg := {}) -> void:
	# Disable collisions for owner
	owner.set_collision_layer_bit(0, false)

	var target_position = Vector2(0, 0)

	var direction_to_target = target_position - owner.position
	var target_angle = direction_to_target.angle() + PI / 2
	var diff = target_angle - owner.rotation
	if diff > PI:
		target_angle -= 2 * PI
	elif diff < -PI:
		target_angle += 2 * PI


	var tween = Tween.new()
	owner.add_child(tween)
	var normal_size = owner.scale
	var duration = 2.0
	tween.interpolate_property(owner, "scale", owner.scale, Vector2.ZERO, duration, 
		Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.interpolate_property(owner, "rotation", owner.rotation, target_angle, duration, 
		Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.interpolate_property(owner, "position", owner.position, target_position, duration, 
		Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)

	tween.connect("tween_completed", self, "_on_tween_completed")
	tween.start()

func _on_tween_completed(object: Object, key: NodePath) -> void:
	# This event is called 3 times - once for each property.
	# finished flag is used to emit only once. 
	if not finished:
		owner.emit_ship_submerged()
		finished = true

func wrap_angle(angle):
	var two_pi = 2 * PI
	return angle - floor(angle / two_pi) * two_pi
