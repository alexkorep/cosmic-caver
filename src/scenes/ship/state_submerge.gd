extends State

func enter(_msg := {}) -> void:
	var target_degrees = owner.rotation_degrees + 360
	var target_position = Vector2(0, 0)

	var tween = Tween.new()
	owner.add_child(tween)
	var normal_size = owner.scale
	var duration = 2.0
	tween.interpolate_property(owner, "scale", owner.scale, Vector2.ZERO, duration, 
		Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.interpolate_property(owner, "rotation_degrees", owner.rotation_degrees, 360, duration, 
		Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.interpolate_property(owner, "position", owner.position, target_position, duration, 
		Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)

	tween.connect("tween_completed", self, "_on_tween_completed")
	tween.start()

func _on_tween_completed(object: Object, key: NodePath) -> void:
	owner.emit_ship_submerged()
