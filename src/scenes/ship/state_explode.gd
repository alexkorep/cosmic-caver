# Idle.gd
extends State

var timer = null

# Upon entering the state, we set the Player node's velocity to zero.
func enter(_msg := {}) -> void:
	owner.Ship.hide()
	owner.ExplosionParticles.emitting = true
	timer = Timer.new()
	timer.connect("timeout", self, "explosion_finished")
	add_child(timer)
	timer.start(2.0)
	
func explosion_finished():
	# Delete timer child
	timer.queue_free()
	timer = null
	owner.emit_ship_exploded()

func exit() -> void:
	pass
