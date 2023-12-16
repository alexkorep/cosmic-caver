extends KinematicBody2D

signal ship_submerged
signal ship_clicked_outside_range
signal ship_exploded

export var max_speed := 100.0
export var max_range := 500

onready var SpaceshipStateMachine = $SpaceshipStateMachine
onready var Explosion = $Explosion
onready var ExplosionParticles = $Explosion/ExplosionParticles
onready var Ship = $Ship

var timer = null

func mission_completed():
	SpaceshipStateMachine.transition_to("Submerge")

func emit_ship_submerged():
	emit_signal("ship_submerged")
	
func emit_clicked_outside_range():
	emit_signal("ship_clicked_outside_range")
	
func explode():
	# TODO move to Expode state
	Ship.hide()
	ExplosionParticles.emitting = true
	# Set 1 second timer to stop emitting particles
	timer = Timer.new()
	#timer.set_wait_time(3.0)
	timer.connect("timeout", self, "explosion_finished")
	add_child(timer)
	timer.start(2.0)

func explosion_finished():
	# Delete timer child
	timer.queue_free()
	timer = null
	emit_signal("ship_exploded")

func on_asteroid_hit(asteroid, body):
	if asteroid.name == 'Asteroid' and body.name == 'Spaceship':
		SpaceshipStateMachine.transition_to("Explode")
