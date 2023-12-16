# Idle.gd
extends State

# Upon entering the state, we set the Player node's velocity to zero.
func enter(_msg := {}) -> void:
	print('Explode!')
	owner.explode()


func exit() -> void:
	#owner.set_collision_layer_bit(0, true)
	pass
