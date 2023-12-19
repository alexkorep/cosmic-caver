extends RigidBody2D

signal dust_particle_dead(body)

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))


func _on_body_entered(body):
	emit_signal("dust_particle_dead", self)

