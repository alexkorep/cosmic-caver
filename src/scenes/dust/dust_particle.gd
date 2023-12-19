extends RigidBody2D

signal dust_particle_dead(body)

func _ready():
	connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body):
	emit_signal("dust_particle_dead", self)
	#if body is Spaceship:
	queue_free()

func _on_RoamTimer_timeout():
	linear_velocity += Vector2(rand_range(-10, 10), rand_range(-10, 10))

func _on_KillTimer_timeout():
	queue_free()
